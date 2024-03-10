import 'package:flutter/material.dart';

class CustomCityField extends StatelessWidget {
  const CustomCityField({super.key, required this.controller});
  final TextEditingController controller;
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
          } else if (value.length < 4) {
            return 'Address must be at least 6 characters long';
          } else if (value.length > 20) {
            return 'City must be less than 100 characters long';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'City',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          fillColor: Color(0xffF5F6FA),
          filled: true,
        ),
      ),
    );
  }
}
