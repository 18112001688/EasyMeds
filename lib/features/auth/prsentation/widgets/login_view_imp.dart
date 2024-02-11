import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/features/auth/prsentation/manger/auth.dart';
import 'package:medcs/features/auth/prsentation/widgets/custom_or_widget.dart';
import 'package:medcs/features/auth/prsentation/widgets/custom_signin_with.dart';
import 'package:medcs/features/auth/prsentation/widgets/email_form_field.dart';
import 'package:medcs/features/auth/prsentation/widgets/pass_form_field.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewImp extends StatefulWidget {
  const LoginViewImp({super.key});

  @override
  State<LoginViewImp> createState() => _LoginViewImpState();
}

bool _isLoding = false;

class _LoginViewImpState extends State<LoginViewImp> {
  final _form = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                            GoRouter.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        'Login',
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
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/ForgetPassword');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 150),
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomPrimaryButton(
                  fontSize: 16,
                  label: 'Login', //
                  onPressed: () {
                    login();
                  },
                  color: AppColors.primaryColor,
                  borderRadius: 32,
                  height: 56,
                  width: 327,
                  borderColor: AppColors.primaryColor,
                  labelColor: Colors.white,
                ),
                const SizedBox(
                  height: 50,
                ),
                const CustomOrWidget(),
                const SizedBox(
                  height: 110,
                ),
                CustomSigninWithButton(
                  text: 'Sign in with google',
                  onPressed: () {
                    try {
                      AuthSevice.signInWithGoogle().then((value) =>
                          GoRouter.of(context).push('/BottomNavBarView'));
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.buildSnackBar(
                              message: "$e", color: Colors.red));
                    }
                  },
                  textColor: Colors.black,
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
                          GoRouter.of(context).push('/BottomNavBarView'));
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.buildSnackBar(
                              message: "$e", color: Colors.red));
                    }
                  },
                  textColor: Colors.black,
                  image: AppImages.facebook,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      if (_form.currentState!.validate()) {
        setState(() {
          _isLoding = true;
        });
        String email = _emailController.text.trim();
        String pass = _passController.text.trim();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);

        if (mounted) {
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            GoRouter.of(context).push('/BottomNavBarView');
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.buildSnackBar(
                    message: 'Logged in successfuly', color: Colors.green));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.buildSnackBar(
                    message: 'PLease Verify your email first.',
                    color: Colors.red));
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        // Handle different authentication errors
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.buildSnackBar(
                  message: 'No user found for this email!', color: Colors.red));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.buildSnackBar(
                  message: 'Wrong password for this email!',
                  color: Colors.red));
        } else {
          // Display the specific Firebase authentication error message
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.buildSnackBar(
                  message: '${e.message}', color: Colors.red));
        }
      }
    } catch (e) {
      if (mounted) {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.buildSnackBar(message: '$e', color: Colors.red));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoding = false;
        });
      }
    }
  }
}
