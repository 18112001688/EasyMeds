import 'package:flutter/material.dart';
import 'package:medcs/core/utlity/styles.dart';

class CustomFormFieldWidget extends StatelessWidget {
  const CustomFormFieldWidget(
      {super.key, required this.name, required this.textFormField});

  final String name;
  final Widget textFormField;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            name,
            style: StylesLight.bodyLarge17,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        textFormField
      ],
    );
  }
}
