import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_peovider.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_bottom_sheet.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_cart.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItem.isEmpty
        ? Scaffold(
            body: SizedBox(
              width: double.infinity,
              child: Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 400,
                      width: 300,
                      child: SvgPicture.asset(AppImages.emptyCart),
                    ),
                    const Text(
                      'Whoops!!',
                      style: TextStyle(
                          color: AppColors.secondryOrange,
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Cart is Empty',
                          style: StylesLight.titleRegualar22,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            bottomSheet: const CustomBottomSheet(),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Center(child: Text('Cart')),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete),
                ),
              ],
              leading: const Text(''),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 50),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                    value: cartProvider.getCartItem.values.toList()[index],
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomCart(),
                    ),
                  )),
            ));
  }
}
