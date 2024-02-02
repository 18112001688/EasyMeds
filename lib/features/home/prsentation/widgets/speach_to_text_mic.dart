import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';

class CustomTextToSpechMic extends StatelessWidget {
  const CustomTextToSpechMic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.068,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: const Icon(
        Icons.mic,
        color: Colors.white,
      ),
    );
  }
}
