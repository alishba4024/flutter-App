import 'package:counter_app/models/product_model.dart';
import 'package:flutter/material.dart';

// Rename to PascalCase for class naming convention
class CartItem {
  int quantity;
  ProductModel product; // Use the correct model name

  CartItem({
    required this.quantity,
    required this.product,
  });
}

// Initialize the list of products from ProductModel's methods
List<ProductModel> products = ProductModel.getCakes(); // Example: Getting cakes

// Initialize cart items using the ProductModel
List<CartItem> cartItems = [
  CartItem(quantity: 2, product: products[0]),
  CartItem(quantity: 1, product: products[1]),
];
