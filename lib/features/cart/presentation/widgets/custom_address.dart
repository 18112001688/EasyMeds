import 'package:flutter/material.dart';

class CustomAddressField extends StatelessWidget {
  const CustomAddressField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 55,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid name';
          } else if (value.length < 5) {
            return 'Address must be at least 6 characters long';
          } else if (value.length > 100) {
            return 'Address must be less than 100 characters long';
          } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
            return 'Address can only contain letters, numbers, and underscores';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Enter your Address',
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
