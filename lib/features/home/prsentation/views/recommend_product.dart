import 'package:flutter/material.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class RecommendedProductView extends StatelessWidget {
  const RecommendedProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommended Product',
          style: themeProvider.isDarkMode
              ? StylesDark.bodyLarge17White
              : StylesLight.bodyLarge17,
        ),
      ),
    );
  }
}
