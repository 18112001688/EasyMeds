import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: kToolbarHeight, // Use the same height as AppBar
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: themeProvider.isDarkMode
          ? AppColors.scaffoldDarkMode
          : Colors.white, // Customize the background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 120),
            child: Text(
              title,
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyLarge17
                  : StylesLight.bodyLarge17,
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
