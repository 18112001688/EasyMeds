import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/splash/prsentation/views/intrduction_three_view.dart';
import 'package:medcs/features/splash/prsentation/views/intrduction_two_view.dart';
import 'package:medcs/features/splash/prsentation/views/intrudction_one_view.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({Key? key}) : super(key: key);

  @override
  GetStartedViewState createState() => GetStartedViewState();
}

class GetStartedViewState extends State<GetStartedView> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? AppColors.scaffoldDarkMode : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: const [
                IntrductionOneView(),
                IntrductionTwoView(),
                IntrudctioThreeView(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              activeDotColor: AppColors.primaryColor,
              dotColor: themeProvider.isDarkMode
                  ? AppColors.secondryScaffold
                  : const Color(0xffECEBED),
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 58,
            width: 305,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              onPressed: () {
                if (currentPage < 2) {
                  // Navigate to the next page
                  controller.animateToPage(
                    currentPage + 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  GoRouter.of(context)
                      .pushReplacement('/GetStartedRegisterView');
                }
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
