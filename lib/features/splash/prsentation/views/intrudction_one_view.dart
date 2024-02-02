import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';

class IntrductionOneView extends StatelessWidget {
  const IntrductionOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SvgPicture.asset(AppImages.doctorImage),
        const SizedBox(
          height: 20,
        ),
        const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome To EasyMeds',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Simplify Your Meds',
          style: TextStyle(
              fontSize: 13,
              fontFamily: 'inter',
              color: AppColors.secondryLight),
        ),
        const Text(
          'and Take Control of Your Health Today',
          style: TextStyle(
              fontSize: 13,
              fontFamily: 'inter',
              color: AppColors.secondryLight),
        )
      ],
    ));
  }
}
