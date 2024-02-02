import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/views/cart_view.dart';
import 'package:medcs/features/home/prsentation/manger/product/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: 120,
      width: 335,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeProvider.isDarkMode
              ? AppColors.scaffoldDarkMode
              : const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              // Inner shadow
              color: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : const Color.fromARGB(
                      255, 238, 238, 238), // Subtle grey shadow
              offset: const Offset(0.0, 1.0), // Slight offset down
              blurRadius: 4.0, // Blur radius
              spreadRadius: 2.0, // No spread
            ),
            BoxShadow(
              // Inner shadow
              color: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : const Color.fromARGB(
                      255, 238, 238, 238), // Subtle grey shadow
              offset: const Offset(0.0, 1.0), // Slight offset down
              blurRadius: 4.0, // Blur radius
              spreadRadius: 2.0, // No spread
            ),
          ],
          border: Border.all(
              color: themeProvider.isDarkMode ? Colors.black : Colors.white)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color(0xffE8F3F1),
                    width: 1,
                  )),
              child: Image.asset(
                AppImages.paecmental,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                children: [
                  Text(
                    'Parcmental',
                    style: themeProvider.isDarkMode
                        ? StylesDark.bodyLarge17
                        : StylesLight.bodyLarge17,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "\$15.99",
                    style:
                        TextStyle(color: AppColors.secondryLight, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomQuantity(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 60),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xffADADAD),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
