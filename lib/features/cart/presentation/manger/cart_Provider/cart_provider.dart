import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
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

  bool isProductInCart({required String productID}) {
    return _cartItems.containsKey(productID);
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

  final usersDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future<void> addToCartFirebase({
    required String productID,
    required int quantity,
    required BuildContext context,
  }) async {
    final User? user = auth.currentUser;
    if (user == null) {
      MyAppMethods.showWarningDialouge(
          isError: false,
          context: context,
          label: 'No user found sign in so you can add products to your cart ',
          onPressedOk: () {
            GoRouter.of(context).push('/LoginView');
          },
          onPressedCancel: () {});
      return; // Add this return statement
    }

    final uid = user.uid;
    final cartID = const Uuid().v4();
    try {
      await usersDB.doc(uid).update({
        "userCart": FieldValue.arrayUnion([
          {
            "cartID": cartID,
            'productID': productID,
            'quantity': quantity,
          }
        ])
      });

      // Update _cartItems right after adding to Firebase
      _cartItems.putIfAbsent(
        productID,
        () => CartModel(
          cartID: cartID,
          productID: productID,
          quantity: quantity,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchCart() async {
    User? user = auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userCart')) {
        return;
      }
      final cartList = List<Map<String, dynamic>>.from(data['userCart']);
      for (final cartItem in cartList) {
        _cartItems.putIfAbsent(
          cartItem['cartID'],
          () => CartModel(
            cartID: cartItem['cartID'],
            productID: cartItem['productID'],
            quantity: cartItem['quantity'],
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearCartFromFirebase() async {
    User? user = auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userCart": [],
      });
      _cartItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeOneItemFromFirebase({
    required String cartID,
    required String productID,
    required int quantity,
  }) async {
    try {
      // Remove the item locally from _cartItems
      _cartItems.remove(productID);
      // Notify listeners to update UI immediately
      notifyListeners();

      // Update Firestore document to reflect the removed item
      User? user = auth.currentUser;
      await usersDB.doc(user!.uid).update({
        "userCart": FieldValue.arrayRemove([
          {
            "cartID": cartID,
            'productID': productID,
            'quantity': quantity,
          }
        ])
      });

      // Fetch updated cart from Firebase to ensure consistency
    } catch (e) {
      // Handle any errors that may occur during the update process

      notifyListeners();
      // Rethrow the error to propagate it upwards
      rethrow;
    }
  }
}
