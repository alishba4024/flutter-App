import 'package:counter_app/checkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:counter_app/database_helper.dart';
import 'package:counter_app/models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    List<Product> cartItems = await DatabaseHelper.instance.fetchCartItems();
    setState(() {
      _cartItems = cartItems;
    });
  }

  Future<void> _removeItem(int id) async {
    await DatabaseHelper.instance.removeProductFromCart(id);
    _loadCartItems(); // Refresh the cart
  }

  double get subtotal => _cartItems.fold(0, (sum, item) => sum + item.price);

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomSheet: Container(
        height: screenHeight * 0.3,
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}", screenWidth),
            SizedBox(height: screenHeight * 0.015),
            const Divider(),
            SizedBox(height: screenHeight * 0.015),
            _buildSummaryRow("Total", "\$${subtotal.toStringAsFixed(2)}", screenWidth),
            SizedBox(height: screenHeight * 0.03),
            _buildCheckoutButton(screenWidth),
          ],
        ),
      ),
      body: _cartItems.isEmpty
          ? const Center(child: Text('No items in cart.'))
          : ListView.separated(
              padding: EdgeInsets.all(screenWidth * 0.05),
              itemCount: _cartItems.length,
              separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.02),
              itemBuilder: (context, index) => _buildCartItem(index, screenWidth, screenHeight),
            ),
    );
  }

  Row _buildSummaryRow(String title, String value, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  GestureDetector _buildCheckoutButton(double screenWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Checkoutscreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff9DCEFF), Color(0xff92A3FD)],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          "Checkout",
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(int index, double screenWidth, double screenHeight) {
    final item = _cartItems[index];
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.025),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _buildProductImage(item.iconPath, screenWidth, screenHeight),
              SizedBox(width: screenWidth * 0.03),
              _buildProductDetails(item, screenWidth),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.01,
          right: screenWidth * 0.02,
          child: _buildCounterAndRemoveButtons(item.id!, screenWidth, screenHeight),
        ),
      ],
    );
  }

  Widget _buildProductImage(String iconPath, double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.11,
      width: screenWidth * 0.2,
      padding: EdgeInsets.all(screenWidth * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          iconPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Column _buildProductDetails(Product item, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          item.text,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          "\$${item.price.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column _buildCounterAndRemoveButtons(int id, double screenWidth, double screenHeight) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _removeItem(id),
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.1),
            child: SvgPicture.asset(
              'assets/icons/trash.svg',
              height: screenWidth * 0.06,
              width: screenWidth * 0.05,
              color: Colors.red.shade300,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.040),
        Row(
          children: [
            _buildCounterButton(
              icon: 'assets/icons/minus-svgrepo-com.svg',
              onTap: _decrementCounter,
              screenWidth: screenWidth,
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: screenWidth * 0.01),
            _buildCounterButton(
              icon: 'assets/icons/plus-svgrepo-com.svg',
              onTap: _incrementCounter,
              screenWidth: screenWidth,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton({required String icon, required VoidCallback onTap, required double screenWidth}) {
    return Container(
      width: screenWidth * 0.08,
      height: screenWidth * 0.08,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          icon,
          height: screenWidth * 0.05,
          width: screenWidth * 0.05,
        ),
      ),
    );
  }
}
