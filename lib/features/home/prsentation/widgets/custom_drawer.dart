import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/product/them_provider/theme_provider.dart';
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
              child: CustomProfileData(
                image: user!.photoURL!,
                name: user.displayName!,
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
          const CustomListTile(
            image: AppImages.accountInfo,
            title: 'Account Information',
          ),
          const CustomListTile(
            image: AppImages.category,
            title: 'Category',
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push('/WishListView');
            },
            child: ListTile(
              leading: Icon(
                IconlyLight.heart,
                color: themeProvider.isDarkMode
                    ? AppColors.secondryLight
                    : AppColors.secondryBlack,
              ),
              title: Text(
                'WishList',
                style: themeProvider.isDarkMode
                    ? StylesDark.bodyLarge17
                    : StylesLight.bodyLarge17,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: themeProvider.isDarkMode
                  ? AppColors.secondryLight
                  : AppColors.secondryBlack,
            ),
            title: Text(
              'Contact us',
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyLarge17
                  : StylesLight.bodyLarge17,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.supervisor_account_rounded,
              color: themeProvider.isDarkMode
                  ? AppColors.secondryLight
                  : AppColors.secondryBlack,
            ),
            title: Text(
              'Help',
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyLarge17
                  : StylesLight.bodyLarge17,
            ),
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontFamily: 'inter'),
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

class CustomProfileData extends StatelessWidget {
  const CustomProfileData({super.key, required this.image, required this.name});

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: themeProvider.isDarkMode
                        ? StylesDark.bodyLarge17
                        : StylesLight.bodyLarge17,
                  ),
                  Row(
                    children: [
                      Text(
                        'Verified Profile',
                        style: themeProvider.isDarkMode
                            ? StylesDark.bodyExtraSmallGrey11
                            : StylesLight.bodyExtraSmallGrey11,
                      ),
                      SvgPicture.asset(AppImages.badge),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListTile(
      leading: SvgPicture.asset(
        image,
        colorFilter: ColorFilter.mode(
          themeProvider.isDarkMode
              ? AppColors.secondryLight
              : AppColors.secondryBlack,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: themeProvider.isDarkMode
            ? StylesDark.bodyLarge17
            : StylesLight.bodyLarge17,
      ),
    );
  }
}
