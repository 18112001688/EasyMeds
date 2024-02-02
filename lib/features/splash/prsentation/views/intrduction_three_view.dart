import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';

class IntrudctioThreeView extends StatelessWidget {
  const IntrudctioThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SvgPicture.asset(
          AppImages.jooging,
          height: 400,
          width: 310,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Mange Your Health  ',
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          ' Let us help you stay on track for ',
          style: TextStyle(
              fontSize: 13,
              fontFamily: 'inter',
              color: AppColors.secondryLight),
        ),
        const Text(
          ' healthier life.',
          style: TextStyle(
              fontSize: 13,
              fontFamily: 'inter',
              color: AppColors.secondryLight),
        )
      ],
    ));
  }
}
