import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/features/auth/prsentation/widgets/email_form_field.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

TextEditingController _emailController = TextEditingController();
final _formState = GlobalKey<FormState>();

bool _isLoading = false;

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Form(
          key: _formState,
          child: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pop();
                              },
                              child: const Icon(Icons.arrow_back)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        'Forget your Password?',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'Enter your phone number and we will send ',
                        style: TextStyle(
                          color: Color(0xffA1A8B0),
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 180),
                      child: Text(
                        'confirmation code',
                        style: TextStyle(
                          color: Color(0xffA1A8B0),
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SvgPicture.asset(AppImages.forgetPass),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomEmailFormField(
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomPrimaryButton(
                      fontSize: 16,
                      label: 'Reset Passwerod',
                      onPressed: () {
                        resetPass();
                      },
                      color: AppColors.primaryColor,
                      borderRadius: 32,
                      height: MediaQuery.of(context).size.height * 0.072,
                      width: MediaQuery.of(context).size.width * 0.91,
                      borderColor: AppColors.primaryColor,
                      labelColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPass() async {
    // If the form is valid:
    if (_formState.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Set loading state to true for UI updates
      });

      String email = _emailController.text.trim();

      try {
        // Send password reset email using FirebaseAuth
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
        );

        // If the widget is still mounted (visible on screen part of the widget tree):
        if (mounted) {
          // Show success snack bar
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.buildSnackBar(
              message: 'Password Reset Email Sent!',
              color: Colors.red,
            ),
          );

          // Navigate back (pop) if still mounted
          GoRouter.of(context).pop();
        }
      } on FirebaseAuthException catch (e) {
        // If an error occurs, show error snack bar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.buildSnackBar(
              message: e.message!,
              color: Colors.red,
            ),
          );
        }

        // Set loading state to false for UI updates
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void showSnackBar(message, color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
