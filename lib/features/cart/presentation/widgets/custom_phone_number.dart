import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField(
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
          if (value == null || value.isEmpty || value.length < 11) {
            return "Please Enter a valid Phone";
          }

          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Enter your phone number',
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
