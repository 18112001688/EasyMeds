import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_quantity_bottom_sheet.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({super.key, required this.qunatity});

  final int qunatity;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? AppColors.scaffoldDarkMode
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: themeProvider.isDarkMode
                ? AppColors.secondryLight
                : AppColors.secondryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28))),
                context: context,
                builder: (context) => const QuantityBottomSheet());
          },
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_down,
              ),
              Text(qunatity.toString())
            ],
          ),
        ),
      ),
    );
  }
}
