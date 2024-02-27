import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/favourite/presentation/manger/wishlist_provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';

import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:provider/provider.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishListProvider>(context);
    final themeProvider = context.watch<ThemeProvider>();

    return wishlistProvider.getWishListItems.isEmpty
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your Wish List is Empty',
                    style: themeProvider.isDarkMode
                        ? StylesDark.titleRegualar22
                        : StylesLight.titleRegualar22,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text('WishList'),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        MyAppMethods.showWarningDialouge(
                            isError: false,
                            context: context,
                            label:
                                'Are you sure of deleting all items in yout WishList',
                            onPressedOk: () {
                              wishlistProvider.clearWishListFromFirebase();
                              GoRouter.of(context).pop();
                            },
                            onPressedCancel: () {
                              GoRouter.of(context).pop();
                            });
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: DynamicHeightGridView(
                builder: (context, index) => ChangeNotifierProvider.value(
                  value: wishlistProvider.getWishListItems.values
                      .toList()
                      .reversed
                      .toList()[index],
                  child: CustomProductCard(
                    productId: wishlistProvider.getWishListItems.values
                        .toList()[index]
                        .productID,
                  ),
                ),
                itemCount: wishlistProvider.getWishListItems.length,
                crossAxisCount: 2,
              ),
            ));
  }
}
