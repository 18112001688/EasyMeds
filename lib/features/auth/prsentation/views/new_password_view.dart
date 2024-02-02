import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/features/auth/prsentation/widgets/confirm_pass_field.dart';
import 'package:medcs/features/auth/prsentation/widgets/pass_form_field.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
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
                height: 80,
              ),
              const Text(
                'Create New Password',
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Create your new password to login',
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 16,
                  color: Color(0xffA1A8B0),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomPasswordFormField(
                controller: passController,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomConfirmPasswordField(),
            ],
          ),
        ),
      ),
    );
  }
}
