import 'package:flutter/material.dart';

class CustomEmailFormField extends StatelessWidget {
  const CustomEmailFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.072,
      width: MediaQuery.of(context).size.width * 0.91,
      padding: const EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter a valid Email";
          }
          if (!RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]+$').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'Enter your email ',
            hintStyle: TextStyle(
              color: Color(0xffA1A8B0),
              fontFamily: 'inter',
              fontSize: 16,
              height: 1.5,
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Color(0xffA1A8B0),
            )),
      ),
    );
  }
}
