import 'package:flutter/material.dart';

class CustomCountryField extends StatelessWidget {
  const CustomCountryField(
      {super.key, required this.controller, required this.fillColor});
  final TextEditingController controller;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 55,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid name';
          } else if (value.length < 5) {
            return 'Address must be at least 6 characters long';
          } else if (value.length > 100) {
            return 'Country must be less than 100 characters long';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Country',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          fillColor: fillColor,
          filled: true,
        ),
      ),
    );
  }
}
