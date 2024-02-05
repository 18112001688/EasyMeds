import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_peovider.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_bottom_sheet.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_cart.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  final bool isEmpty = false;

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
                    CustomPrimaryButton(
                        label: 'Go Shopping',
                        onPressed: () {
                          GoRouter.of(context).push('/BottomNavBarView');
                        },
                        color: AppColors.primaryColor,
                        borderRadius: 10,
                        height: 50,
                        width: 140,
                        borderColor: AppColors.primaryColor,
                        labelColor: Colors.white,
                        fontSize: 12),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            bottomSheet: const CustomBottomSheet(),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              leading: IconButton(
                  onPressed: () {
                    GoRouter.of(context).push('/BottomNavBar');
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: const Center(child: Text('Cart')),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete),
                ),
              ],
            ),
            body: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                    value: cartProvider.getCartItem.values.toList()[index],
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CustomCart(),
                    ),
                  )),
            ));
  }
}
