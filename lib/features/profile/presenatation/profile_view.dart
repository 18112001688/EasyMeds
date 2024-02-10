import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(text: 'Profile'),
            const SizedBox(
              height: 5,
            ),
            const CircleAvatar(
              radius: 40,
            ),
            CustomProfileOptions(
              image: AppImages.helpDisk,
              onTap: () {},
              text: 'Help Center',
            ),
            CustomProfileOptions(
              image: AppImages.document,
              onTap: () {},
              text: 'WishList',
            ),
            CustomProfileOptions(
              image: AppImages.language,
              onTap: () {},
              text: 'Change Language',
            ),
            CustomProfileOptions(
              image: AppImages.contactUs2,
              onTap: () {},
              text: 'contact us',
            ),
            CustomProfileOptions(
              image: AppImages.inviteFriends,
              onTap: () {},
              text: 'Invite Friends',
            ),
            CustomProfileOptions(
              image: AppImages.chats,
              onTap: () {},
              text: 'Privacy and Policy',
            ),
            CustomProfileOptions(
              image: AppImages.logout,
              onTap: () async {
                await MyAppMethods.showWarningDialouge(
                    isError: false,
                    context: context,
                    label: 'Are you sure you want to logout',
                    onPressedOk: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    onPressedCancel: () {
                      GoRouter.of(context).pop();
                    });
              },
              text: 'Logout',
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          const Icon(Icons.arrow_back),
          const SizedBox(width: 105),
          Text(
            text,
            style: themeProvider.isDarkMode
                ? StylesDark.bodyLarge17SemiBold
                : StylesLight.bodyLarge17,
          )
        ],
      ),
    );
  }
}

class CustomContainerCircle extends StatelessWidget {
  const CustomContainerCircle({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Container(
      height: 45,
      width: 45,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: themeProvider.isDarkMode
            ? AppColors.secondryScaffold
            : AppColors.secondryPurple,
      ),
      child: SvgPicture.asset(image),
    );
  }
}

class CustomProfileOptions extends StatelessWidget {
  const CustomProfileOptions(
      {super.key,
      required this.text,
      required this.image,
      required this.onTap});

  final String text;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          CustomContainerCircle(
            image: image,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(text,
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyLarge17
                  : StylesLight.bodyLarge17),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: GestureDetector(
                onTap: onTap, child: const Icon(Icons.arrow_forward_ios)),
          )
        ],
      ),
    );
  }
}
