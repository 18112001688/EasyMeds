import 'package:flutter/material.dart';

class CustomNameField extends StatelessWidget {
  const CustomNameField(
      {super.key, required this.controller, required this.fillColor});
  final TextEditingController controller;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 55,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid name';
          } else if (value.length < 3) {
            return 'Name must be at least 3 characters long';
          } else if (value.length > 20) {
            return 'Name must be less than 20 characters long';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Enter your name',
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
