import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcs/features/profile/data/models/order_check_out_model.dart';

class CheckoutOrderProvider with ChangeNotifier {
  final List<CheckoutOrder> _checkoutOrders = [];

  List<CheckoutOrder> get checkoutOrders => _checkoutOrders;

  final checkOutDB =
      FirebaseFirestore.instance.collection('userCheckoutOrders');
  Future<List<CheckoutOrder>> fetchCheckOutOrders() async {
    try {
      await checkOutDB.get().then((chekOutSnapShot) {
        _checkoutOrders.clear();
        for (var element in chekOutSnapShot.docs) {
          _checkoutOrders.insert(0, CheckoutOrder.fromFirestore(element));
        }
      });
      notifyListeners();
      return _checkoutOrders;
    } catch (error) {
      rethrow;
    }
  }
}
