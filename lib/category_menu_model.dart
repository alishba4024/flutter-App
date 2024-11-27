import 'package:flutter/material.dart';

class CategoryMenuModel {
  final String name;
  final String iconPath; // Path to the category icon
  final Color boxColor; // Color for the category box
  CategoryMenuModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });
  // Sample categories
  static List<CategoryMenuModel> getCategories() {
    return [
      CategoryMenuModel(
        name: 'Gelato',
        // iconPath: 'assets/icons/pancake.svg',
        iconPath: 'assets/images/gelato.jpg',
        boxColor: Color(0xffcf88f2), // Example color
      ),
      CategoryMenuModel(
        name: 'Sorbet',
        iconPath: 'assets/images/sorbet.jpg',
        boxColor: Color(0xff92A3FD), // Example color
      ),
      CategoryMenuModel(
        name: 'Popsicles',
        iconPath: 'assets/images/frozenyogurt.jpg',
        boxColor: Color(0xffcf88f2), // Example color
      ),
    ];
  }
}