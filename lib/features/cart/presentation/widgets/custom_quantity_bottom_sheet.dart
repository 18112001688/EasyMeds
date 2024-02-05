import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/features/cart/data/models/cart_model.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_peovider.dart';
import 'package:provider/provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key, required this.cartModel});
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final qunantityProvider = context.watch<CartProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              // shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  qunantityProvider.updateQuantity(
                      productID: cartModel.productID, quantity: index + 1);

                  GoRouter.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
