import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/product/them_provider/theme_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 200,
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
            const Row(
              children: [
                Text(
                  'Total',
                  style: TextStyle(color: AppColors.secondryLight),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  '\$120',
                  style: TextStyle(color: AppColors.secondryBlack),
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
