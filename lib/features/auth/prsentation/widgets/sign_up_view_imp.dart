import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_loading.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/features/auth/prsentation/manger/auth.dart';
import 'package:medcs/features/auth/prsentation/widgets/custom_or_widget.dart';
import 'package:medcs/features/auth/prsentation/widgets/custom_signin_with.dart';
import 'package:medcs/features/auth/prsentation/widgets/email_form_field.dart';
import 'package:medcs/features/auth/prsentation/widgets/pass_form_field.dart';
import 'package:medcs/features/auth/prsentation/widgets/username_field.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpViewImp extends StatefulWidget {
  const SignUpViewImp({super.key});

  @override
  State<SignUpViewImp> createState() => _SignUpViewImpState();
}

class _SignUpViewImpState extends State<SignUpViewImp> {
  bool _isAgreed = false;
  bool _isLoding = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CustomLoadingIndicator(),
      inAsyncCall: _isLoding,
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .push('/GetStartedRegisterView');
                          },
                          child: const Icon(Icons.arrow_back)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomUsernameFormField(
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomEmailFormField(
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomPasswordFormField(
                  controller: _passController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        activeColor: AppColors.primaryColor,
                        value: _isAgreed,
                        onChanged: (newValue) {
                          setState(() {
                            _isAgreed = newValue!;
                          });
                        }),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'I agree to the medidoc ',
                              style: TextStyle(fontFamily: 'inter'),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push('/TermsAndCondtions');
                              },
                              child: const Text(
                                'Terms of Service',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: 'inter'),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 135),
                          child: Row(
                            children: [
                              Text('and'),
                              Text(
                                ' Privacy Policy',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: 'inter'),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomPrimaryButton(
                  fontSize: 16,
                  label: 'Sign up', //
                  //!_isAgreed is true: The user has not agreed to the terms. Show an error message.
                  onPressed: () {
                    if (!_isAgreed) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.buildSnackBar(
                              message:
                                  'Please agree to the terms and policy to proceed!',
                              color: Colors.red));
                    } else {
                      signUp(context);
                      // ...
                    }
                  },
                  color: AppColors.primaryColor,
                  borderRadius: 32,
                  height: MediaQuery.of(context).size.height * 0.072,
                  width: MediaQuery.of(context).size.width * 0.91,
                  borderColor: AppColors.primaryColor,
                  labelColor: Colors.white,
                ),
                const SizedBox(
                  height: 50,
                ),
                const CustomOrWidget(),
                const SizedBox(
                  height: 45,
                ),
                CustomSigninWithButton(
                  text: 'Sign in with google',
                  onPressed: () {
                    try {
                      AuthSevice.signInWithGoogle().then((value) =>
                          GoRouter.of(context)
                              .pushReplacement('/BottomNavBarView'));
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.buildSnackBar(
                              message: "$e", color: Colors.red));
                    }
                  },
                  image: AppImages.google,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomSigninWithButton(
                  text: 'Sign in with facebook',
                  onPressed: () {
                    try {
                      AuthSevice.signInWithFacebook().then((value) =>
                          GoRouter.of(context)
                              .pushReplacement('/BottomNavBarView'));
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.buildSnackBar(
                              message: "$e", color: Colors.red));
                    }
                  },
                  image: AppImages.facebook,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    if (_form.currentState!.validate()) {
      setState(() {
        _isLoding = true;
      });

      try {
        final String email = _emailController.text.trim();
        final String password = _passController.text.trim();

        // Create the user and send verification email immediately
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((userCredential) =>
                userCredential.user!.sendEmailVerification());

        final User? user = FirebaseAuth.instance.currentUser;
        final uid = user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "userID": uid,
          "userName": _nameController.text.toLowerCase(),
          "userEmail": _emailController.text.toLowerCase(),
          "userImage": "",
          "createdAt": Timestamp.now(),
          "userWish": [],
          "userCart": []
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.buildSnackBar(
              message: 'Verification email sent. Please check your inbox.',
              color: Colors.green,
            ),
          );
          GoRouter.of(context).push('/LoginView');
        }

        setState(() {
          _isLoding = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoding = false;
        });
        if (mounted) {
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.buildSnackBar(
                message:
                    'The given password is invalid, Password should be at least 6 characters',
                color: Colors.red,
              ),
            );

            // Handle weak password error
          } else if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.buildSnackBar(
                message: 'The email is already in use!',
                color: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.buildSnackBar(
                message: 'Error during user registration: $e',
                color: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        setState(() {
          _isLoding = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.buildSnackBar(
              message: 'An unexpected error occurred. Please try again.',
              color: Colors.red,
            ),
          );
        }
      }
    }
  }
}
