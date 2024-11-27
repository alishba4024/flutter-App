import 'package:flutter/material.dart';

class DietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool viewIsSelected;
  Color boxColor;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.viewIsSelected,
    required this.boxColor
  });

  static List < DietModel > getDiets(){
    List < DietModel > diets = [];


    diets.add(
    DietModel(
      name: 'Gelato',
      iconPath: 'assets/images/gelato.jpg',
      level: 'Easy',
      duration: '30mins',
      calorie: '100kCal',
      viewIsSelected: true,
      boxColor: Color(0xff92A3FD)
    )
    );

     diets.add(
    DietModel(
      name: 'Sorbat',
      iconPath: 'assets/images/sorbet.jpg',
      level: 'Easy',
      duration: '20mins',
      calorie: '230kCal',
      viewIsSelected: false,
      boxColor: Color(0xffcf88f2)
    )
    );

     diets.add(
    DietModel(
      name: 'Frozen Yogurt',
      iconPath: 'assets/images/frozenyogurt.jpg',
      level: 'Easy',
      duration: '20mins',
      calorie: '230kCal',
      viewIsSelected: false,
      boxColor: Color(0xff92A3FD)
    )
    );

   return diets;

  }
  
}