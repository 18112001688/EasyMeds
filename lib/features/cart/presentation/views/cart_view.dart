import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/features/cart/data/models/cart_model.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_peovider.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_bottom_sheet.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_cart.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_quantity_bottom_sheet.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartModelProvider = Provider.of<CartModel>(context);
    final productProvider = context.watch<ProductProvider>();

    final getCurrentProduct =
        productProvider.findByProductID(cartModelProvider.cartID);

    return isEmpty
        ? Scaffold(
            body: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 400,
                    width: 300,
                    child: SvgPicture.asset(AppImages.emptyCart),
                  ),
                  const Text(
                    'Whoops!!',
                    style: TextStyle(
                        color: AppColors.secondryOrange,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Your Cart is Empty',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Go find products you like",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomPrimaryButton(
                      label: 'Go Shopping',
                      onPressed: () {
                        GoRouter.of(context).push('/HomeView');
                      },
                      color: AppColors.primaryColor,
                      borderRadius: 10,
                      height: 50,
                      width: 140,
                      borderColor: AppColors.primaryColor,
                      labelColor: Colors.white,
                      fontSize: 12),
                ],
              ),
            ),
          )
        : Scaffold(
            bottomSheet: const CustomBottomSheet(),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              leading: IconButton(
                  onPressed: () {
                    GoRouter.of(context).push('/BottomNavBar');
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: const Center(child: Text('Cart')),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                    value: cartProvider.getCartItem.values.toList()[index],
                    child: CustomCart(
                      label: getCurrentProduct!.title,
                      price: getCurrentProduct.price,
                      quntity: cartModelProvider.quantity,
                      image: getCurrentProduct.image,
                    ),
                  )),
            ));
  }
}

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({super.key, required this.qunatity});

  final int qunatity;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? AppColors.scaffoldDarkMode
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: themeProvider.isDarkMode
                ? AppColors.secondryLight
                : AppColors.secondryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28))),
                context: context,
                builder: (context) => const QuantityBottomSheet());
          },
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_down,
              ),
              Text(qunatity.toString())
            ],
          ),
        ),
      ),
    );
  }
}
