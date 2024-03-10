import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 400,
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
                    const Text(
                      'Deleviery Address',
                      style: StylesLight.bodyLarge17,
                    ),
                    GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/DeliveryAdressView');
                        },
                        child: const Icon(Icons.arrow_forward_ios))
                  ],
                )
              ],
            ),
            Text(
              'Order Info',
              style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.white
                      : AppColors.secondryBlack,
                  fontSize: 17),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : AppColors.secondryBlack),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping cost',
                  style: StylesLight.bodyMeduimGrey15,
                ),
                Text(
                  '\$20',
                  style: TextStyle(color: AppColors.secondryBlack),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Total items (${cartProvider.getCartItem.length})',
                  style: const TextStyle(color: AppColors.secondryLight),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${cartProvider.getTotal(productProvider: productProvider)}',
                  style: const TextStyle(color: AppColors.secondryBlack),
                ),
                const Spacer(),
                CustomPrimaryButton(
                  label: 'Checkout',
                  onPressed: () {},
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
    );
  }
}
