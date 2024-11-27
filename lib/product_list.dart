import 'package:counter_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  final List<ProductModel> products;
  ProductList({required this.products});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 15),
          _buildItem(),
        ],
      ),
    );
  }

  Widget _buildItem() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        itemCount: widget.products.length,
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    image: product.iconPath,
                    title: product.name,
                    backgroundColor: product.boxColor,
                    shortDes: product.text,
                    Des: product.description,
                    basePrice: product.price,
                  ),
                ),
              );
            },
            child: Material(
              // elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.10),
                        blurRadius: 60,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 11,right: 9),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18), 
                          child: Image.asset(
                            product.iconPath,
                            width: 90,
                            height: 80,
                            fit: BoxFit .fitHeight,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/right-arrow-svgrepo-com.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                              Text(
                                product.text,
                                style: const TextStyle(
                                  color: Color(0xff7B6f72),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  // const Text(
                                  //   '\$',
                                  //   style: TextStyle(
                                  //     fontSize: 15,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Text(
                                    '\$${product.price.toStringAsFixed(0)}', // Convert double to string
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Category Items',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
        child: _buildIcon('assets/icons/left-arrow-svgrepo-com (1).svg'),
      ),
      actions: [
        _buildIcon('assets/icons/three-small-dots-svgrepo-com.svg'),
      ],
    );
  }

  Widget _buildIcon(String asset) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: SvgPicture.asset(asset, height: 20),
    );
  }

  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search...',
            hintStyle: const TextStyle(fontSize: 18),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  height: 3,
                  width: 5,
                  child: SvgPicture.asset('assets/icons/search.svg')),
            ),
            // suffixIcon: SvgPicture.asset(''),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
