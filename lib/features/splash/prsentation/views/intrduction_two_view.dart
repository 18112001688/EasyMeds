import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';

class IntrductionTwoView extends StatelessWidget {
  const IntrductionTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          SvgPicture.asset(
            AppImages.mobileInterface,
            height: 400,
            width: 420,
          ),
          const Text(
            'Features ',
            style: TextStyle(
                fontSize: 28, fontFamily: 'inter', fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Effortless Prescription Refills',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'inter',
              color: AppColors.secondryLight,
            ),
          ),
          const Text(
            'Organize and Access Health Info Easily',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'inter',
              color: AppColors.secondryLight,
            ),
          )
        ],
      ),
    ));
  }
}
