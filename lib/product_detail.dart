import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:counter_app/cart_screen.dart';
import 'package:counter_app/database_helper.dart';
import 'package:counter_app/models/product.dart';

class ProductDetail extends StatefulWidget {
  final String image;
  final String title;
  final Color backgroundColor;
  final String shortDes;
  final String Des;
  final double basePrice;

  const ProductDetail({
    Key? key,
    required this.image,
    required this.title,
    required this.backgroundColor,
    required this.shortDes,
    required this.Des,
    required this.basePrice,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _counter = 1;
  double _totalPrice = 0.0;
  final dbHelper = DatabaseHelper.instance;
  Color selectIconColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _totalPrice = widget.basePrice;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _totalPrice = widget.basePrice * _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _totalPrice = widget.basePrice * _counter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.13),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.246,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(widget.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          buttonArrow(context, screenWidth, screenHeight),
          scrollSheet(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget buttonArrow(BuildContext context, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.06, left: screenWidth * 0.03),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: screenWidth * 0.12,
          width: screenWidth * 0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: SvgPicture.asset(
                'assets/icons/left-arrow-svgrepo-com (1).svg'),
          ),
        ),
      ),
    );
  }

  Widget scrollSheet(double screenWidth, double screenHeight) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (_, controller) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: widget.backgroundColor.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                widget.shortDes,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        quantityCounter(screenWidth),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      widget.Des,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              totalPriceRow(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.05),
              addToCartButton(screenWidth),
            ],
          ),
        );
      },
    );
  }

  Widget quantityCounter(double screenWidth) {
    return Row(
      children: [
        quantityButton('minus', _decrementCounter, screenWidth),
        SizedBox(width: screenWidth * 0.02),
        Text(
          '$_counter',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06,
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        quantityButton('plus', _incrementCounter, screenWidth),
      ],
    );
  }

  Widget quantityButton(String icon, VoidCallback onPressed, double screenWidth) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.08,
      height: screenWidth * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: SvgPicture.asset('assets/icons/$icon-svgrepo-com.svg'),
      ),
    );
  }

 Widget totalPriceRow(double screenWidth, double screenHeight) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.03), // Right padding for heart icon
        child: CircleAvatar(
          radius: screenWidth * 0.06,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectIconColor = selectIconColor == Colors.black ? Colors.red : Colors.black;
              });
            },
            child: SvgPicture.asset(
              'assets/icons/heart-svgrepo-com (1).svg',
              color: selectIconColor,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: screenWidth * 0.03), // Right padding for Total Price column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Total Price',
              style: TextStyle(
                color: Colors.black54,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              _totalPrice.toStringAsFixed(2),
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}



  Widget addToCartButton(double screenWidth) {
    return GestureDetector(
      onTap: _addToCart,
      child: Container(
        height: 45,
        width: screenWidth * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xff9DCEFF), Color(0xff92A3FD)]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'Add to cart',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.045,
            ),
          ),
        ),
      ),
    );
  }

  void _addToCart() async {
    Product product = Product(
      iconPath: widget.image,
      name: widget.title,
      boxColor: widget.backgroundColor.toString(),
      text: widget.shortDes,
      description: widget.Des,
      price: _totalPrice,
    );
    await dbHelper.addProductToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart!')),
    );
  }
}
