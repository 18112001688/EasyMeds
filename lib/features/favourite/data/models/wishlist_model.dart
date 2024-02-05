import 'package:flutter/material.dart';

class WishListModel with ChangeNotifier {
  final String wishListID;
  final String productID;

  WishListModel({
    required this.wishListID,
    required this.productID,
  });
}
