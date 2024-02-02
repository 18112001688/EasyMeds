import 'package:flutter/material.dart';
import 'package:medcs/features/auth/prsentation/widgets/login_view_imp.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewImp(),
    );
  }
}
