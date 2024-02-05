import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_quantity_bottom_sheet.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
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
                    'Your  is Empty',
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
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    GoRouter.of(context).push('/BottomNavBar');
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: const Center(
                child: Text('WishList'),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DynamicHeightGridView(
                builder: (context, index) => const CustomProductCard(
                  productId: '',
                ),
                itemCount: 20,
                crossAxisCount: 2,
              ),
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
