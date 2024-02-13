import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsModel with ChangeNotifier {
  final String productTitle;
  final double productPrice;
  final String productDescription;
  final String productQuantity;
  final String productImage;
  final String productID;
  final String productCategory;
  final Timestamp createdAt;

  ProductsModel(
      {required this.productTitle,
      required this.productPrice,
      required this.productDescription,
      required this.productQuantity,
      required this.productImage,
      required this.productID,
      required this.productCategory,
      required this.createdAt});

  factory ProductsModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return ProductsModel(
        productTitle: data['productTitle'],
        productPrice: double.parse(data['productPrice']),
        productDescription: data['productDescription'],
        productQuantity: data['productQuantity'],
        productImage: data['productImage'],
        productID: data['productID'],
        productCategory: data['productCategory'],
        createdAt: data['createdAt']);
  }
}
