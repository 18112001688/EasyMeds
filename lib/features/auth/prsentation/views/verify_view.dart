import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/features/auth/prsentation/widgets/verfictaioncode_form.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SvgPicture.asset(AppImages.forgetPass),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomVerifactionCodeField(),
                    CustomVerifactionCodeField(),
                    CustomVerifactionCodeField(),
                    CustomVerifactionCodeField(),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomPrimaryButton(
                  fontSize: 16,
                  label: 'Verify',
                  onPressed: () {
                    GoRouter.of(context).push('/NewPasswordView');
                  },
                  color: AppColors.primaryColor,
                  borderRadius: 32,
                  height: MediaQuery.of(context).size.height * 0.072,
                  width: MediaQuery.of(context).size.width * 0.91,
                  borderColor: AppColors.primaryColor,
                  labelColor: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn’t receive the code? ',
                      style: TextStyle(
                        color: Color(0xff717784),
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
