import 'package:flutter/material.dart';
class ProductModel {
  final String iconPath;
  final String name;
  final Color boxColor;
  final String text;
  final String description;
  final double price;
  ProductModel({
    required this.iconPath,
    required this.name,
    required this.boxColor,
    required this.text,
    required this.description,
    required this.price,
  });
  static List<ProductModel> getCakes() {
    return [
      ProductModel(
        iconPath: 'assets/images/chocolate.jpg',
        name: 'Chocolate Ice cream',
        boxColor: Color(0xffcf88f2),
        text: 'Try our creamy chocolate ice cream',
        description: 'Our chocolate ice cream is crafted with the utmost care, using only the highest quality ingredients. The rich, velvety texture melts on your tongue, while the intense chocolate flavor satisfies your sweetest cravings.',
        price: 250.00,
      ),
      ProductModel(
        iconPath: 'assets/images/vanilla.jpg',
        name: 'Vanilla Ice cream',
        boxColor: Color(0xffcf88f2),
        text: 'Try our creamy vanilla ice cream.',
        description: 'Our creamy vanilla ice cream is the perfect classic treat. Its a timeless flavor everyone loves. The rich, velvety texture melts on your tongue, while the subtle sweetness of the vanilla beans provides a comforting and satisfying taste.',
        price: 350.00,
      ),
      ProductModel(
        iconPath: 'assets/images/strawberry.jpg',
        name: 'Strawberry Ice cream',
        boxColor: Color(0xffcf88f2),
        text: 'Try our Strawberry ice cream.',
        description: 'Our strawberry ice cream is a burst of sweet and tangy flavor. Its the perfect summer treat. The creamy texture is infused with the natural sweetness and tartness of real strawberries, creating a balanced and refreshing taste. ',
        price: 500.00,
      ),
      ProductModel(
        iconPath: 'assets/images/pista.jpg',
        name: 'Pistachio Ice cream',
        boxColor: Color(0xffcf88f2),
        text: 'Try Our pistachio ice cream.',
        description: 'Our pistachio ice cream is a rich and creamy delight with a subtle nutty flavor. Made with real pistachios, its a unique and satisfying treat. The creamy texture is infused with the delicate flavor of pistachios, creating a balanced and satisfying taste. ',
        price: 580.00,
      ),
      // Add more cake products as needed
    ];
  }
  static List<ProductModel> getSalads() {
    return [
      ProductModel(
        iconPath: 'assets/images/berry.jpg',
        name: 'Berry Bliss Ice cream',
        boxColor: Color(0xff92A3FD),
        text: 'Try our creamy Berry ice cream.',
        description: 'Indulge in a burst of summery flavor with our Berry Bliss ice cream. Every spoonful is a delightful symphony of ripe, juicy berries swirled into a creamy vanilla base. The perfect balance of sweet and tart, this ice cream is a refreshing treat for any occasion.',
        price: 450.00,
      ),
      ProductModel(
        iconPath: 'assets/images/trophical.jpg',
        name: 'Tropical Paradise Ice cream',
        boxColor:Color(0xff92A3FD),
        text: 'Try our creamy Trophical ice cream.',
        description: 'Escape to the tropics with our refreshing Tropical Paradise ice cream. This creamy delight is bursting with the flavors of exotic fruits like mango, pineapple, and coconut. Each spoonful is a taste of paradise.',
        price: 290.00,
      ),
      ProductModel(
        iconPath: 'assets/images/citrus.jpg',
        name: 'Citrus Sunshine Ice cream',
        boxColor: Color(0xff92A3FD),
        text: 'Try our creamy Citrus ice cream.',
        description: 'Our citrus ice cream is a refreshing burst of sunshine. Made with zesty lemons, tangy limes, and sweet oranges, This creamy ice cream is made with a blend of zesty lemon, tangy lime, and sweet orange. A perfect summer treat! ',
        price: 350.00,
      ),
      
      // Add more salad products as needed
    ];
  }
  static List<ProductModel> getPancakes() {
    return [
      ProductModel(
        iconPath: 'assets/images/classic.jpg',
        name: 'Classic Vanilla Ice cream',
        boxColor: Color(0xffcf88f2),
        text: 'Try our creamy Vanilla ice cream.',
        description: 'A timeless classic, our Vanilla Ice Cream is smooth, creamy, and undeniably delicious. Made with the finest ingredients, its the perfect base for any ice cream sundae or dessert.',
        price: 500.00,
      ),
      ProductModel(
        iconPath: 'assets/images/fruity.jpg',
        name: 'Fruity Delight Ice cream',
        boxColor:Color(0xffcf88f2),
        text: 'Try our fruity delight icecream.',
        description: 'A fruity fiesta in every scoop! This vibrant ice cream is a delightful blend of various fruits, offering a burst of refreshing flavors in every bite.',
        price: 250.00,
      ),
      ProductModel(
        iconPath: 'assets/images/classics.jpg',
        name: 'Strawberry Cheesecake',
        boxColor: Color(0xffcf88f2),
        text: 'Try our Strawberry ice cream.',
        description: 'A decadent dessert experience. Our Strawberry Cheesecake ice cream blends the creamy richness of cheesecake with the sweet tanginess of fresh strawberries. Each spoonful is a delightful combination of flavors and textures.',
        price: 400.00,
      ),
      // Add more pancake products as needed
    ];
  }
  

  
}