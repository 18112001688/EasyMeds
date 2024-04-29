import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/features/profile/data/models/order_check_out_model.dart';
import 'package:medcs/features/search/presentation/widgets/build_order_card.dart';

class OrdersHistoryView extends StatelessWidget {
  const OrdersHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders History'),
        actions: [
          IconButton(
              onPressed: () {
                _deleteHistory(context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: StreamBuilder<List<CheckoutOrder>>(
        stream: _fetchOrdersStream(),
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
                return buildOrderCard(context, order);
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

  Future<void> _deleteHistory(BuildContext context) async {
    try {
      MyAppMethods.showWarningDialouge(
          isError: true,
          context: context,
          label: 'Are you sure you want to delete the order history',
          onPressedOk: () async {
            await FirebaseFirestore.instance
                .collection('userCheckoutOrders')
                .get()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
                doc.reference.delete();
              }
            });
            if (context.mounted) {
              GoRouter.of(context).pop();
            }
          },
          onPressedCancel: () {
            GoRouter.of(context).pop();
          });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
