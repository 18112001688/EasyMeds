import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/cart/presentation/views/cart_view.dart';
import 'package:medcs/features/favourite/presentation/manger/wishlist_provider.dart';
import 'package:medcs/features/favourite/presentation/views/wishlist_view.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/views/home_view.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_drawer.dart';
import 'package:medcs/features/profile/presenatation/profile_view.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/search/presentation/views/search_view.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

int currentIndex = 0;
bool isLoadingProds = true;

List views = const [
  HomeView(),
  SearchView(),
  CartView(),
  WishListView(),
  ProfileView(),
];

class _BottomNavBarViewState extends State<BottomNavBarView> {
  Future<void> fetchFCT() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);

    try {
      Future.wait(
        {
          productProvider.fetchProducts(),
        },
      );
      //make sure to listien to auth changes to know if the user really signed out or not
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          // User has logged out, clear the cart and wishlist
          cartProvider.clearLocalCart();
          wishListProvider.clearLocalWishList();
        } else {
          cartProvider.fetchCart();
          wishListProvider.fetchWishList();
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.buildSnackBar(
          message: 'an error has occured $e', color: Colors.red));
    } finally {
      setState(() {
        isLoadingProds = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProds) {
      fetchFCT();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: themeProvider.isDarkMode
                ? AppColors.secondryScaffold
                : AppColors.scaffoldLightMode,
            type: BottomNavigationBarType.fixed,
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
                        label: Text(
                          cartProvider.getCartItem.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(IconlyLight.buy,
                            color: AppColors.secondryLight),
                      ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: currentIndex == 3
                    ? const Text(
                        'WishList',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : Badge(
                        label: Text(
                          wishListProvider.getWishListItems.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        child: const Icon(IconlyLight.heart,
                            color: AppColors.secondryLight),
                      ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: currentIndex == 4
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
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: views[currentIndex],
      ),
      drawer: const CustomHomeDrawer(),
    );
  }
}
