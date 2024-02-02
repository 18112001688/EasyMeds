import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';

class CustomUploadPrescriptionCard extends StatelessWidget {
  const CustomUploadPrescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 340,
      decoration: const BoxDecoration(
          color: Color(0xffEEE9FF),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        children: [
          const Positioned(
            left: 20,
            top: 20,
            child: Text('Order Quickly With', style: StylesLight.bodyLarge17),
          ),
          const Positioned(
            left: 20,
            top: 40,
            child: Text(
              'Prescription',
              style: StylesLight.bodyLarge17,
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: CustomPrimaryButton(
              fontSize: 12,
              label: 'Upload Prescription',
              labelColor: Colors.white,
              borderRadius: 8,
              borderColor: AppColors.primaryColor,
              color: AppColors.primaryColor,
              height: 40,
              width: 170,
              onPressed: () {},
            ),
          ),
          Positioned(
              top: 40,
              left: 250,
              child: SvgPicture.asset(
                AppImages.group,
                height: 70,
              )),
        ],
      ),
    );
  }
}
