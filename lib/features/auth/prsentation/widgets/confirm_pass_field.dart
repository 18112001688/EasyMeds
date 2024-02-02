import 'package:flutter/material.dart';

class CustomConfirmPasswordField extends StatefulWidget {
  const CustomConfirmPasswordField({super.key});

  @override
  State<CustomConfirmPasswordField> createState() =>
      _CustomPasswordFormFieldState();
}

bool _obsecureText = true;

class _CustomPasswordFormFieldState extends State<CustomConfirmPasswordField> {
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
          if (value == null || value.isEmpty) {
            return "Please Enter a valid password";
          }
          if (value.length < 6) {
            "password must be at least 6 numbers";
          }
          return null;
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'Confirm passwrod',
            hintStyle: const TextStyle(
              color: Color(0xffA1A8B0),
              fontFamily: 'inter',
              fontSize: 16,
              height: 1.5,
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
            prefixIcon: const Icon(
              Icons.lock_outlined,
              color: Color(0xffA1A8B0),
              size: 30,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              icon: Icon(
                _obsecureText ? Icons.visibility_off : Icons.visibility,
              ),
            )),
        obscureText: _obsecureText,
      ),
    );
  }
}
