import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';

class CustomPhoneFormField extends StatelessWidget {
  const CustomPhoneFormField({super.key});

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
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 11) {
            return "Please Enter a valid Phone";
          }

          return null;
        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'Enter your Phone Number ',
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
              Icons.phone_outlined,
              color: AppColors.primaryColor,
            )),
      ),
    );
  }
}
