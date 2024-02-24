import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
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

  final usersDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  Future<void> addToWishListFirebase({
    required String productID,
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
    final wishListID = const Uuid().v4();
    try {
      await usersDB.doc(uid).update({
        "userWish": FieldValue.arrayUnion([
          {
            "WishListID": wishListID,
            'productID': productID,
          }
        ])
      });

      // Update _cartItems right after adding to Firebase
      _wishListItems.putIfAbsent(
        productID,
        () => WishListModel(
          productID: productID,
          wishListID: wishListID,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishList() async {
    User? user = auth.currentUser;
    if (user == null) {
      _wishListItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userWish')) {
        return;
      }
      final wishList = List<Map<String, dynamic>>.from(data['userWish']);
      for (final wishItems in wishList) {
        _wishListItems.putIfAbsent(
          wishItems['wishListID'],
          () => WishListModel(
              productID: wishItems['productID'],
              wishListID: wishItems['wishListID']),
        );
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearWishListFromFirebase() async {
    User? user = auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userWish": [],
      });
      _wishListItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeOneItemFromFirebase({
    required String wishListID,
    required String productID,
  }) async {
    try {
      // Remove the item locally from _cartItems
      _wishListItems.remove(productID);
      // Notify listeners to update UI immediately
      notifyListeners();

      // Update Firestore document to reflect the removed item
      User? user = auth.currentUser;
      await usersDB.doc(user!.uid).update({
        "userWish": FieldValue.arrayRemove([
          {
            "wishListID": wishListID,
            'productID': productID,
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
