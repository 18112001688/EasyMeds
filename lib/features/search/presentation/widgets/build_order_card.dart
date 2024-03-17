import 'package:flutter/material.dart';
import 'package:medcs/features/profile/data/models/order_check_out_model.dart';

Widget buildOrderCard(BuildContext context, CheckoutOrder order) {
  return Card(
    color: Colors.white,
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Images Column
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order.items.map((item) {
                return Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(item['productImage']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 20),
          // Order Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order.items.map((item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item['productName'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // Maximum of 1 line
                    ),
                    const SizedBox(height: 4),
                    // User Name
                    Text(
                      'User Name: ${order.userName}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    // Delivery Address
                    Text(
                      'Delivery Address: ${order.deliveryAddress}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    // Total Items and Total
                    Text(
                      'Total Items: ${order.totalItems}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Total: ${order.getTotal}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
