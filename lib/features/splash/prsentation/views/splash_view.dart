import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Hide the status bar and navigation bar by setting the mode to immersive
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate a splash screen delay
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Navigate to login screen if user is not signed in
      if (mounted) {
        GoRouter.of(context).pushReplacement('/GetStartedView');
      }
    } else {
      // Navigate to home screen if user is signed in
      if (mounted) {
        GoRouter.of(context).pushReplacement('/BottomNavBarView');
      }
    }
  }

  @override
  void dispose() {
    // Show the status bar and navigation bar after pushing to home screen and returning to standard mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Image.asset(AppImages.splashImage)),
    );
  }
}
