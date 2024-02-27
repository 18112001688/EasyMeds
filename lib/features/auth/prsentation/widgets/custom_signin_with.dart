import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomSigninWithButton extends StatelessWidget {
  const CustomSigninWithButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.image});

  final String text;
  final VoidCallback onPressed;
  final String image;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.072,
      width: MediaQuery.of(context).size.width * 0.91,
      child: MaterialButton(
        color: themeProvider.isDarkMode
            ? AppColors.secondryScaffold
            : const Color(0xffF9FAFB),
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(image),
            const SizedBox(
              width: 50,
            ),
            Text(
              text,
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                fontSize: 16,
                fontFamily: 'inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
