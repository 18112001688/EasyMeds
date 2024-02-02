import 'package:flutter/material.dart';

class CustomVerifactionCodeField extends StatelessWidget {
  const CustomVerifactionCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.16,
      padding: const EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter a valid Number";
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
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
        ),
      ),
    );
  }
}
