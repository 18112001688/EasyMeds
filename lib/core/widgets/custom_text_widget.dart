import 'package:flutter/material.dart';

class CustomHeadingText extends StatelessWidget {
  const CustomHeadingText({
    super.key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.fontsize,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'inter',
        fontWeight: fontWeight,
        fontSize: fontsize,
      ),
    );
  }
}

class CustomBodyText extends StatelessWidget {
  const CustomBodyText({
    super.key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.fontsize,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: 'inter',
          fontWeight: fontWeight,
          fontSize: fontsize),
    );
  }
}
