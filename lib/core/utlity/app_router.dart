import 'package:go_router/go_router.dart';
import 'package:medcs/features/auth/prsentation/views/forget_pass.dart';
import 'package:medcs/features/auth/prsentation/views/login_view.dart';
import 'package:medcs/features/auth/prsentation/views/sign_up_view.dart';
import 'package:medcs/features/auth/prsentation/views/verify_view.dart';
import 'package:medcs/features/cart/presentation/views/cart_view.dart';
import 'package:medcs/features/favourite/presentation/views/wishlist_view.dart';
import 'package:medcs/features/home/prsentation/views/bottomNavBar_view.dart';
import 'package:medcs/features/home/prsentation/views/home_view.dart';
import 'package:medcs/features/home/prsentation/views/product_details_view.dart';
import 'package:medcs/features/search/presentation/views/search_view.dart';
import 'package:medcs/features/splash/prsentation/views/get_started_register_view.dart';
import 'package:medcs/features/splash/prsentation/views/get_started_view.dart';
import 'package:medcs/features/splash/prsentation/views/splash_view.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: "/GetStartedView",
        builder: (context, state) => const GetStartedView(),
      ),
      GoRoute(
        path: '/GetStartedRegisterView',
        builder: (context, state) => const GetStartedRegisterView(),
      ),
      GoRoute(
        path: '/SignUpView',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/LoginView',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/BottomNavBarView',
        builder: (context, state) => const BottomNavBarView(),
      ),
      GoRoute(
        path: '/HomeView',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
          path: '/WishListView',
          builder: (context, state) => const WishListView()),
      GoRoute(
        path: '/CartView',
        builder: (context, state) => const CartView(),
      ),
      GoRoute(
        path: '/ForgetPassword',
        builder: (context, state) => const ForgetPassword(),
      ),
      GoRoute(
        path: '/VerificationCodeView',
        builder: (context, state) => const VerificationCodeView(),
      ),
      GoRoute(
        path: '/SearchView',
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: '/ProductDetailsView',
        builder: (context, state) => const ProductDetailsView(),
      ),
    ],
  );
}
