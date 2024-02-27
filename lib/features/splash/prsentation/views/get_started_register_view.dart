import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class GetStartedRegisterView extends StatelessWidget {
  const GetStartedRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_pharmacy_rounded,
              size: 80,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Let's get started!",
              style: TextStyle(
                  fontSize: 22,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Login to enjoy the features we’ve ",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.secondryLight,
                  fontFamily: 'inter',
                )),
            const Text("provided, and stay healthy!",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.secondryLight,
                  fontFamily: 'inter',
                )),
            const SizedBox(
              height: 60,
            ),
            CustomPrimaryButton(
              fontSize: 16,
              label: 'Guest',
              onPressed: () {
                GoRouter.of(context).pushReplacement('/BottomNavBarView');
              },
              color: AppColors.primaryColor,
              borderRadius: 32,
              height: MediaQuery.of(context).size.height * 0.072,
              width: MediaQuery.of(context).size.width * 0.73,
              borderColor: AppColors.primaryColor,
              labelColor: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPrimaryButton(
              fontSize: 16,
              label: 'Login',
              onPressed: () {
                GoRouter.of(context).push('/LoginView');
              },
              color: AppColors.primaryColor,
              borderRadius: 32,
              height: MediaQuery.of(context).size.height * 0.072,
              width: MediaQuery.of(context).size.width * 0.73,
              borderColor: AppColors.primaryColor,
              labelColor: Colors.white,
            ),
            const SizedBox(height: 10),
            CustomPrimaryButton(
              fontSize: 16,
              label: 'Sign Up',
              onPressed: () {
                GoRouter.of(context).push('/SignUpView');
              },
              color: themeProvider.isDarkMode
                  ? AppColors.secondryBlack
                  : Colors.white,
              borderRadius: 32,
              height: MediaQuery.of(context).size.height * 0.072,
              width: MediaQuery.of(context).size.width * 0.73,
              borderColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
