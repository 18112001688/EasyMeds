import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_loading.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/auth/data/model/user_model.dart';
import 'package:medcs/features/auth/prsentation/manger/user_provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/cutom_profile_option.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.buildSnackBar(
          message: 'An error has occured $e',
          color: Colors.red,
        ));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    if (userModel == null) {
      fetchUserInfo();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          progressIndicator: const CustomLoadingIndicator(),
          inAsyncCall: _isLoading,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 3)),
                      child: CircleAvatar(
                        backgroundImage: userModel?.userImage != null
                            ? NetworkImage(userModel!.userImage)
                            : const NetworkImage(
                                "https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg"),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel?.userName ?? "",
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          userModel?.userEmail ?? "",
                          style: StylesDark.bodyExtraSmall11,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomProfileOptions(
                image: AppImages.helpDisk,
                onTap: () {},
                text: 'Help Center',
              ),
              CustomProfileOptions(
                image: AppImages.document,
                onTap: () {
                  GoRouter.of(context).push('/OrdersHistoryView');
                },
                text: 'orders',
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
              user == null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomProfileOptions(
                        image: AppImages.logout,
                        onTap: () async {
                          GoRouter.of(context).push('/LoginView');
                        },
                        text: 'Login',
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomProfileOptions(
                        image: AppImages.logout,
                        onTap: () async {
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
                        text: 'Logout',
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
