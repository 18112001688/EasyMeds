import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/search/presentation/views/search_view.dart';
import 'package:provider/provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';

class CustomCategoryRounded extends StatelessWidget {
  const CustomCategoryRounded(
      {super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(arguments: name),
            builder: ((context) => const SearchView()),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30, top: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1,
                      color: themeProvider.isDarkMode
                          ? AppColors.secondryScaffold
                          : const Color(0xffE8F3F1))),
              child: CircleAvatar(
                  backgroundColor: themeProvider.isDarkMode
                      ? AppColors.secondryScaffold
                      : AppColors.scaffoldLightMode,
                  radius: 25,
                  child: SvgPicture.asset(image)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyExtraSmall11Wite
                  : StylesLight.bodyExtraSmall11,
            )
          ],
        ),
      ),
    );
  }
}
