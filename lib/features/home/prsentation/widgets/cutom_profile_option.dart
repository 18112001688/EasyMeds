import 'package:flutter/material.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_container_circle.dart';
import 'package:provider/provider.dart';

class CustomProfileOptions extends StatelessWidget {
  const CustomProfileOptions(
      {super.key,
      required this.text,
      required this.image,
      required this.onTap});

  final String text;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          CustomContainerCircle(
            image: image,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(text,
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyLarge17
                  : StylesLight.bodyLarge17),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: GestureDetector(
                onTap: onTap, child: const Icon(Icons.arrow_forward_ios)),
          )
        ],
      ),
    );
  }
}
