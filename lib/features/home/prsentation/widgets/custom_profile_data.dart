import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomProfileData extends StatelessWidget {
  const CustomProfileData({super.key, required this.image, required this.name});

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: themeProvider.isDarkMode
                        ? StylesDark.bodyLarge17
                        : StylesLight.bodyLarge17,
                  ),
                  Row(
                    children: [
                      Text(
                        'Verified Profile',
                        style: themeProvider.isDarkMode
                            ? StylesDark.bodyExtraSmallGrey11
                            : StylesLight.bodyExtraSmallGrey11,
                      ),
                      SvgPicture.asset(AppImages.badge),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
