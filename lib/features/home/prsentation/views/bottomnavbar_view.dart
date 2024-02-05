import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_peovider.dart';
import 'package:medcs/features/cart/presentation/views/cart_view.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/views/home_view.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_drawer.dart';
import 'package:medcs/features/profile/presenatation/profile_view.dart';
import 'package:medcs/features/search/presentation/views/search_view.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

int currentIndex = 0;

List views = const [
  HomeView(),
  SearchView(),
  CartView(),
  ProfileView(),
];

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 120,
          child: BottomNavigationBar(
              backgroundColor: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : AppColors.scaffoldLightMode,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: currentIndex == 0
                      ? const Text(
                          'Home',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Icon(
                          IconlyLight.home,
                          color: AppColors.secondryLight,
                        ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: currentIndex == 1
                      ? const Text(
                          'Search',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Icon(IconlyLight.search,
                          color: AppColors.secondryLight),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: currentIndex == 2
                      ? const Text(
                          'Cart',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Badge(
                          backgroundColor: AppColors.primaryColor,
                          label:
                              Text(cartProvider.getCartItem.length.toString()),
                          child: const Icon(IconlyLight.buy,
                              color: AppColors.secondryLight)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: currentIndex == 3
                      ? const Text(
                          'Profile',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Icon(IconlyLight.profile,
                          color: AppColors.secondryLight),
                  label: "",
                ),
              ]),
        ),
        body: views[currentIndex],
        drawer: const CustomHomeDrawer());
  }
}
