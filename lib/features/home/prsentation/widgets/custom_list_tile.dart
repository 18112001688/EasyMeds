import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListTile(
      leading: SvgPicture.asset(
        image,
        colorFilter: ColorFilter.mode(
          themeProvider.isDarkMode
              ? AppColors.secondryLight
              : AppColors.secondryBlack,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: themeProvider.isDarkMode
            ? StylesDark.bodyLarge17
            : StylesLight.bodyLarge17,
      ),
    );
  }
}