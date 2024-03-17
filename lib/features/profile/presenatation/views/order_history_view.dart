import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medcs/features/profile/data/models/order_check_out_model.dart';
import 'package:medcs/features/profile/presenatation/manger/check_out_provider.dart';
import 'package:provider/provider.dart';

class OrdersHistoryView extends StatelessWidget {
  const OrdersHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
      ),
      body: StreamBuilder<List<CheckoutOrder>>(
        stream:
            _fetchOrdersStream(), // Your method to get the stream of CheckoutOrders
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<CheckoutOrder>? checkoutOrders = snapshot.data;
            if (checkoutOrders == null || checkoutOrders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
            return ListView.builder(
              itemCount: checkoutOrders.length,
              itemBuilder: (context, index) {
                final CheckoutOrder order = checkoutOrders[index];

                return ListTile(
                  title: Text(order.userName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Address: ${order.deliveryAddress}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text('Total Items: ${order.totalItems}'),
                      Text(
                          'Total: ${order.getTotal}'), // Call the method getTotal
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Stream<List<CheckoutOrder>> _fetchOrdersStream() {
    return FirebaseFirestore.instance
        .collection('userCheckoutOrders')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CheckoutOrder.fromFirestore(doc))
            .toList());
  }
}
