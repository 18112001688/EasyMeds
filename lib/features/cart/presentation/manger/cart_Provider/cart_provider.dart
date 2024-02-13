import 'package:flutter/material.dart';
import 'package:medcs/features/cart/data/models/cart_model.dart';
import 'package:medcs/features/home/data/models/product_model.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  // A map to store cart items. The key is productID and the value is CartModel.

  final Map<String, CartModel> _cartItems = {};
  // Getter to return a copy of _cartItems.

  Map<String, CartModel> get getCartItem {
    return _cartItems;
  }
  // Checks if a product is already in the cart.

  bool isProductInCart({required String productID}) {
    return _cartItems.containsKey(productID);
  }

  // Adds a product to the cart. If the product is already in the cart, it doesn't add it again.
  void addProductToCart({required String productID}) {
    _cartItems.putIfAbsent(
        productID,
        () => CartModel(
            cartID: const Uuid().v4(), productID: productID, quantity: 1));

    notifyListeners();
  }

  // Updates the quantity of a product in the cart.
  void updateQuantity({required String productID, required int quantity}) {
    _cartItems.update(
      productID,
      (item) => CartModel(
        cartID: item.cartID,
        productID: productID,
        quantity: quantity,
      ),
    );

    notifyListeners();
  }

  // Calculates the total price of all items in the cart.
  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    //The function then iterates over _cartItems using forEach. For each item in the cart, it does the following:
    _cartItems.forEach(
      (key, value) {
        final ProductsModel? getCurrentProduct =
            productProvider.findByProductID(value.productID);

        if (getCurrentProduct == null) {
          return;
        } else {
          total += getCurrentProduct.productPrice.toDouble() * value.quantity;
        }
      },
    );
    return total;
  }

  // Removes an item from the cart.
  void removeOneItem({required String productID}) {
    _cartItems.remove(productID);
    notifyListeners();
  }

// remove all items from the cart
  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
