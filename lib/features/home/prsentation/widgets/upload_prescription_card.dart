import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CustomUploadPrescriptionCard extends StatelessWidget {
  const CustomUploadPrescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 135,
      width: 340,
      decoration: BoxDecoration(
          color: themeProvider.isDarkMode
              ? AppColors.secondryScaffold
              : const Color(0xffEEE9FF),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Text('Order Quickly With',
                style: themeProvider.isDarkMode
                    ? StylesDark.titleRegualar22White
                    : StylesLight.titleRegualar22),
          ),
          Positioned(
            left: 20,
            top: 45,
            child: Text(
              'Prescription',
              style: themeProvider.isDarkMode
                  ? StylesDark.titleRegualar22White
                  : StylesLight.titleRegualar22,
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
