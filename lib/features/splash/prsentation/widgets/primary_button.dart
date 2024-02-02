import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.color,
      required this.borderRadius,
      required this.height,
      required this.width,
      required this.borderColor,
      required this.labelColor,
      required this.fontSize});
  final double height;
  final double width;
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final Color labelColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all(
                BorderSide(color: borderColor, width: 2)),
            backgroundColor: MaterialStatePropertyAll(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)))),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              color: labelColor,
              fontSize: fontSize,
              fontFamily: 'inter',
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
