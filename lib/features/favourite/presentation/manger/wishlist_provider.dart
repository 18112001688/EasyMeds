import 'package:flutter/material.dart';
import 'package:medcs/features/favourite/data/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishListItems = {};

  Map<String, WishListModel> get getWishListItems {
    return _wishListItems;
  }

  bool isProductInWishList({required String productID}) {
    return _wishListItems.containsKey(productID);
  }

  void addOrRemoveProductFromWishList({required String productID}) {
    if (_wishListItems.containsKey(productID)) {
      _wishListItems.remove(productID);
    } else {
      _wishListItems.putIfAbsent(
          productID,
          () => WishListModel(
              wishListID: const Uuid().v4(), productID: productID));
    }

    notifyListeners();
  }

  void clearLocalWishList() {
    _wishListItems.clear();
    notifyListeners();
  }
}
