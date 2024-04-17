import 'package:flutter/material.dart';

class CustomReviewFormField extends StatelessWidget {
  const CustomReviewFormField(
      {super.key, required this.controller, required this.fillColor});
  final TextEditingController controller;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 170,
      child: TextFormField(
        maxLines: 4000,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid Review';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Describe your experience',
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
