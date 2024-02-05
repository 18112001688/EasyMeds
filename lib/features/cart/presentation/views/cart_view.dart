import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
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
          )
        : Scaffold(
            bottomSheet: const CustomBottomSheet(),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Center(child: Text('Cart')),
              actions: [
                IconButton(
                    onPressed: () {
                      MyAppMethods.showWarningDialouge(
                          isError: false,
                          context: context,
                          label:
                              'Are you sure of deleting all items in yout cart',
                          onPressedOk: () {
                            cartProvider.clearLocalCart();
                            GoRouter.of(context).pop();
                          },
                          onPressedCancel: () {
                            GoRouter.of(context).pop();
                          });
                    },
                    icon: const Icon(Icons.delete)),
              ],
              leading: const Text(''),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 200),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                    value: cartProvider.getCartItem.values
                        .toList()
                        .reversed
                        .toList()[index],
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: CustomCart(),
                    ),
                  )),
            ));
  }
}
