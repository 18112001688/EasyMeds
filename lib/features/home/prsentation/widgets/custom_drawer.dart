import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_profile_data.dart';
import 'package:provider/provider.dart';

class CustomHomeDrawer extends StatelessWidget {
  const CustomHomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = context.watch<ThemeProvider>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(),
              child: user == null
                  ? const SizedBox.shrink()
                  : CustomProfileData(
                      image: user.photoURL ?? "",
                      name: user.displayName ?? "",
                    )),
          SwitchListTile(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeColor: AppColors.primaryColor,
            title: Row(
              children: [
                SvgPicture.asset(
                  AppImages.sun,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color ?? Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Dark Mode',
                  style: themeProvider.isDarkMode
                      ? StylesDark.bodyLarge17
                      : StylesLight.bodyLarge17,
                ),
              ],
            ),
          ),
          user == null
              ? const SizedBox.shrink()
              : ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: themeProvider.isDarkMode
                        ? AppColors.secondryLight
                        : AppColors.secondryBlack,
                  ),
                  title: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/ContactUsView');
                    },
                    child: Text(
                      'Contact us',
                      style: themeProvider.isDarkMode
                          ? StylesDark.bodyLarge17
                          : StylesLight.bodyLarge17,
                    ),
                  ),
                ),
          ListTile(
            leading: Icon(
              Icons.supervisor_account_rounded,
              color: themeProvider.isDarkMode
                  ? AppColors.secondryLight
                  : AppColors.secondryBlack,
            ),
            title: GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/HelpCenterView');
              },
              child: Text(
                'Help',
                style: themeProvider.isDarkMode
                    ? StylesDark.bodyLarge17
                    : StylesLight.bodyLarge17,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.history_edu_outlined,
              color: themeProvider.isDarkMode
                  ? AppColors.secondryLight
                  : AppColors.secondryBlack,
            ),
            title: GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/OrdersHistoryView');
              },
              child: Text(
                'Order History',
                style: themeProvider.isDarkMode
                    ? StylesDark.bodyLarge17
                    : StylesLight.bodyLarge17,
              ),
            ),
          ),
          user == null
              ? const SizedBox.shrink()
              : ListTile(
                  title: GestureDetector(
                    onTap: () {
                      MyAppMethods.showWarningDialouge(
                          isError: false,
                          context: context,
                          label: 'Are you sure you want to logout',
                          onPressedOk: () async {
                            await FirebaseAuth.instance.signOut();

                            if (context.mounted) {
                              GoRouter.of(context)
                                  .push('/GetStartedRegisterView');
                            }
                          },
                          onPressedCancel: () {
                            GoRouter.of(context).pop();
                          });
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red, fontFamily: 'inter'),
                    ),
                  ),
                  leading: SvgPicture.asset(
                    AppImages.logout,
                    colorFilter: const ColorFilter.mode(
                      Color(0xffFF5757),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
