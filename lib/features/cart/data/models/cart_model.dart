import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String cartID;
  final String productID;
  final int quantity;
  final String productName;
  final String productImage;

  CartModel({
    required this.cartID,
    required this.productID,
    required this.quantity,
    required this.productName,
    required this.productImage,
  });
}
