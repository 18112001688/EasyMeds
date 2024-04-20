import 'package:flutter/material.dart';

class CustomNameReviewField extends StatelessWidget {
  const CustomNameReviewField(
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
          }
          if (value.length > 20) {
            return 'Name should not exceed 14 characters';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Type your Name',
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
