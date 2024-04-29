import 'package:go_router/go_router.dart';
import 'package:medcs/features/auth/prsentation/views/forget_pass.dart';
import 'package:medcs/features/auth/prsentation/views/login_view.dart';
import 'package:medcs/features/auth/prsentation/views/sign_up_view.dart';
import 'package:medcs/features/auth/prsentation/views/verify_view.dart';
import 'package:medcs/features/cart/presentation/views/cart_view.dart';
import 'package:medcs/features/cart/presentation/views/delivery_address_view.dart';
import 'package:medcs/features/cart/presentation/views/payment_view.dart';
import 'package:medcs/features/favourite/presentation/views/wishlist_view.dart';
import 'package:medcs/features/home/prsentation/views/Add_review_view.dart';
import 'package:medcs/features/home/prsentation/views/bottomNavBar_view.dart';
import 'package:medcs/features/home/prsentation/views/home_view.dart';
import 'package:medcs/features/home/prsentation/views/product_details_view.dart';
import 'package:medcs/features/home/prsentation/views/reviews_view.dart';
import 'package:medcs/features/home/prsentation/views/upload_prescription_view.dart';
import 'package:medcs/features/profile/presenatation/views/contact_us_view.dart';
import 'package:medcs/features/profile/presenatation/views/help_center_view.dart';
import 'package:medcs/features/profile/presenatation/views/order_history_view.dart';
import 'package:medcs/features/profile/presenatation/views/privacy_policy_view.dart';
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
      GoRoute(
        path: '/UploadPrescriptionView',
        builder: (context, state) => const UploadPrescriptionView(),
      ),
      GoRoute(
        path: '/DeliveryAdressView',
        builder: (context, state) => const DeliveryAdressView(),
      ),
      GoRoute(
        path: '/PaymentView',
        builder: (context, state) => const PaymentView(),
      ),
      GoRoute(
        path: '/OrdersHistoryView',
        builder: (context, state) => const OrdersHistoryView(),
      ),
      GoRoute(
        path: '/ReviewsView',
        builder: (context, state) => ReviewsView(
          productId: (state.extra as String),
        ),
      ),
      GoRoute(
        path: '/AddReviewView',
        builder: (context, state) => AddReviewView(
          productID: (state.extra as String),
        ),
      ),
      GoRoute(
        path: '/HelpCenterView',
        builder: (context, state) => const HelpCenterView(),
      ),
      GoRoute(
        path: '/ContactUsView',
        builder: (context, state) => const ContactUsView(),
      ),
      GoRoute(
        path: '/PrivacyAndPolicy',
        builder: (context, state) => const PrivacyAndPolicy(),
      ),
    ],
  );
}
