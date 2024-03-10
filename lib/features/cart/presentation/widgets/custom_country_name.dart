import 'package:flutter/material.dart';

class CustomCountryField extends StatelessWidget {
  const CustomCountryField({super.key, required this.controller});
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
          } else if (value.length < 5) {
            return 'Address must be at least 6 characters long';
          } else if (value.length > 100) {
            return 'Country must be less than 100 characters long';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Country',
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
