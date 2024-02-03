import 'package:flutter/material.dart';
import 'package:medcs/features/cart/data/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItem {
    return _cartItems;
  }

  bool isProductInCart({required String productID}) {
    return _cartItems.containsKey(productID);
  }

  void addProductToCart({required String productID}) {
    _cartItems.putIfAbsent(
        productID,
        () => CartModel(
            cartID: const Uuid().v4(), productID: productID, quantity: 1));

    notifyListeners();
  }
}
