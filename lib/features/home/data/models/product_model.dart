import 'package:flutter/material.dart';

class ProductsModel with ChangeNotifier {
  final String title;
  final double price;
  final String description;
  final double quantity;
  final String image;
  final String id;
  final String category;

  ProductsModel(
      {required this.title,
      required this.price,
      required this.description,
      required this.quantity,
      required this.image,
      required this.id,
      required this.category});
}
