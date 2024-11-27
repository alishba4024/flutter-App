
import 'package:counter_app/models/product_model.dart';
import 'package:counter_app/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 

class ProductCards extends StatefulWidget {
  ProductCards({super.key});

  @override
  State<ProductCards> createState() => _ProductCardsState();
  
}

class _ProductCardsState extends State<ProductCards> {
  @override
  Widget build(BuildContext context) {

    final List<ProductModel> products = [
   ...ProductModel.getCakes(),
   ...ProductModel.getSalads(),
   ...ProductModel.getPancakes(),
  ];

    return Scaffold(
        // appBar: appBar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                   mainAxisExtent: 220,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, index) {
                      final product = products[index];
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
                      child: Container(
                        height: 220,
                        width: 180,
                        margin: EdgeInsets.only(left: 0, right: 0),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              // side: BorderSide(color: Colors.grey)
                              ),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: 135,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                                        child: Image.asset(products[index].iconPath),
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Column(
                                          children: [
                                            SvgPicture.asset('assets/icons/star.svg',
                                            color: Colors.yellow,),
                                            Text(
                                              '3.5',
                                              style: TextStyle(
                                                color: Colors.white,
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 80,
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            products[index].name,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: SvgPicture.asset(
                                            "assets/icons/heart.svg",
                                            height: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5, left: 5),
                                      child: Container(
                                        width: 55,
                                        height: 19,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Color(0xfffff0f0),
                                            border:
                                                Border.all(color: Color(0xffd2a6a6))),
                                        child: Text(
                                          '460 kcal',
                                          //  '\$${products[index].price.toStringAsFixed(0)}',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffc36767)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ));
  }

  // AppBar appBar(BuildContext context) {
  //   return AppBar(
  //     title: const Text(
  //       'Menu Items',
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     backgroundColor: Colors.white,
  //     centerTitle: true,
  //     leading: GestureDetector(
  //       onTap: () {
  //         Navigator.of(context).pop(); // Now context is accessible
  //       },
  //       // child: Container(
  //       //   margin: const EdgeInsets.all(10),
  //       //   alignment: Alignment.center,
  //       //   child: SvgPicture.asset(
  //       //     'assets/icons/left-arrow-svgrepo-com (1).svg',
  //       //     height: 20,
  //       //     width: 20,
  //       //   ),
  //       //   decoration: BoxDecoration(
  //       //     color: const Color(0xffF7f8F8),
  //       //     borderRadius: BorderRadius.circular(10),
  //       //   ),
  //       // ),
  //     ),
  //     actions: [
  //       GestureDetector(
  //         child: Container(
  //           margin: const EdgeInsets.all(10),
  //           alignment: Alignment.center,
  //           width: 37,
  //           child: SvgPicture.asset(
  //             'assets/icons/three-small-dots-svgrepo-com.svg',
  //             height: 15,
  //             width: 10,
  //           ),
  //           decoration: BoxDecoration(
  //             color: const Color(0xffF7f8F8),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
