import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 55,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 11) {
            return "Please Enter a valid Phone";
          }

          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Enter your phone number',
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
