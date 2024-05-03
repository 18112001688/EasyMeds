import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/utlity/styles.dart';

class CustomContactUsWidget extends StatelessWidget {
  const CustomContactUsWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.ontap,
  });

  final String text;
  final String icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 51,
          width: 304,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(icon),
              const SizedBox(
                width: 75,
              ),
              Text(
                text,
                style: StylesLight.bodyLarge17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
