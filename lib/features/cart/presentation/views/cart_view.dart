import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_bottom_sheet.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_cart.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String returnedAddress = 'No address added'; // Initialize with default value

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                    child: SvgPicture.asset(AppImages
                        .emptyCart), // Replace 'assets/images/empty_cart.svg' with your actual image path
                  ),
                  const Text(
                    'Whoops!!',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Cart is Empty',
                        style: themeProvider.isDarkMode
                            ? const TextStyle(
                                fontSize: 22,
                              )
                            : const TextStyle(
                                fontSize: 22,
                              ),
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
            bottomSheet: CustomBottomSheet(
              addressSent:
                  returnedAddress, // Pass the address to CustomBottomSheet
            ),
            appBar: AppBar(
              title: const Text('Cart'),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showWarningDialouge(
                      context: context,
                      isError: false,
                      label:
                          'Are you sure you want to delete all items in your cart?',
                      onPressedOk: () {
                        cartProvider.clearCartFromFirebase();
                        GoRouter.of(context).pop();
                      },
                      onPressedCancel: () {
                        GoRouter.of(context).pop();
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 200),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: cartProvider.getCartItem.values
                    .toList()
                    .reversed
                    .toList()[index],
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: CustomCart(),
                ),
              ),
            ),
          );
  }
}
