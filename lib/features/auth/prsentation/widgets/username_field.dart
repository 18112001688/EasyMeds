import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomUsernameFormField extends StatelessWidget {
  const CustomUsernameFormField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.072,
      width: MediaQuery.of(context).size.width * 0.91,
      padding: const EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? AppColors.secondryScaffold
            : const Color(0xffF9FAFB),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter a Valid Username";
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Enter your name ',
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
            Icons.person_outline_rounded,
            color: Color(0xffA1A8B0),
            size: 30,
          ),
        ),
      ),
    );
  }
}
