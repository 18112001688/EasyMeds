import 'package:flutter/material.dart';
import 'package:medcs/features/auth/prsentation/widgets/sign_up_view_imp.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpViewImp(),
    );
  }
}
