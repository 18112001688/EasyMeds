import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/cart/presentation/views/delivery_address_view.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_cart.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String address = 'No address added'; // Initialize with default value
  bool _isLoading = false;

  void updateAddress(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  Future<void> checkOut() async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (address == 'No address added') {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.buildSnackBar(
            message: 'you must add address in order to check out',
            color: Colors.deepOrange));
      } else {
        final auth = FirebaseAuth.instance.currentUser;
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        List<Map<String, dynamic>> cartItems = [];

        for (var cartItem in cartProvider.getCartItem.values) {
          cartItems.add({
            'productName': cartItem.productName,
            'quantity': cartItem.quantity,
            'productImage': cartItem.productImage
          });
        }

        await FirebaseFirestore.instance.collection('userCheckoutOrders').add({
          'userID': auth!.uid,
          'userName': auth.displayName,
          'userEmail': auth.email,
          'userPhone': auth.phoneNumber,
          'userImage': auth.photoURL,
          'deliveryAddress': address,
          'totalItems': 'Total items (${cartProvider.getCartItem.length})',
          'getTotal':
              '\$${cartProvider.getTotal(productProvider: productProvider)}',
          'items': cartItems
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.buildSnackBar(
              message:
                  'your order is placed successfully we will contact you soon ',
              color: Colors.green));
        }
      }
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

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
        : ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: Scaffold(
              bottomSheet: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? AppColors.scaffoldDarkMode
                      : Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Address',
                                style: themeProvider.isDarkMode
                                    ? StylesDark.bodyLarge17White
                                    : StylesLight.bodyLarge17,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final newAddress = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DeliveryAdressView(),
                                    ),
                                  );
                                  if (newAddress != null) {
                                    updateAddress(newAddress);
                                  }
                                },
                                child: const Icon(Icons.arrow_forward_ios),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                address,
                                style: const TextStyle(
                                    color: AppColors.secondryLight,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Payment',
                                style: StylesLight.bodyLarge17,
                              ),
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).push('/PaymentView');
                                },
                                child: const Icon(Icons.arrow_forward_ios),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                'Cash',
                                style: TextStyle(
                                    color: AppColors.secondryLight,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Order Info',
                        style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : AppColors.secondryBlack,
                            fontSize: 17),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Shipping cost',
                            style: StylesLight.bodyMeduimGrey15,
                          ),
                          Text(
                            '\$20',
                            style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : AppColors.secondryBlack),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'Total items (${cartProvider.getCartItem.length})',
                            style:
                                const TextStyle(color: AppColors.secondryLight),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${cartProvider.getTotal(productProvider: productProvider)}',
                            style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : AppColors.secondryBlack),
                          ),
                          const Spacer(),
                          CustomPrimaryButton(
                            label: 'Checkout',
                            onPressed: checkOut,
                            color: AppColors.primaryColor,
                            borderRadius: 14,
                            height: 40,
                            width: 150,
                            borderColor: AppColors.primaryColor,
                            labelColor: Colors.white,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomAppBar(
                        title: 'Cart',
                        onDeletePressed: () {
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
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 200),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: cartProvider.getCartItem.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onDeletePressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight, // Use the same height as AppBar
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white, // Customize the background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 120),
            child: Text(
              title,
              style: StylesLight.bodyLarge17,
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
