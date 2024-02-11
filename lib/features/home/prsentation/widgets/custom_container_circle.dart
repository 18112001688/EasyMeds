import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomContainerCircle extends StatelessWidget {
  const CustomContainerCircle({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Container(
      height: 45,
      width: 45,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: themeProvider.isDarkMode
            ? AppColors.secondryScaffold
            : AppColors.secondryPurple,
      ),
      child: SvgPicture.asset(image),
    );
  }
}
