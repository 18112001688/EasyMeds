import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';

import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';

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
