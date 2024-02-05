import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/features/favourite/presentation/manger/wishlist_provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/views/product_details_view.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:provider/provider.dart';
// ... other imports

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    super.key,
    required this.productId,
  });
  final String productId;
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final productProvider = context.watch<ProductProvider>();
    final getCurrentProduct = productProvider.findByProductID(productId);
    final wishlistProvider = Provider.of<WishListProvider>(context);

    // Define a consistent text style for the title
    final titleTextStyle = TextStyle(
      color: themeProvider.isDarkMode ? Colors.white : const Color(0xff010101),
      fontSize: 14,
      fontFamily: 'inter',
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis, // Handle long titles
    );

    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 200,
              width: 160,
              child: Container(
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? AppColors.secondryScaffold
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: themeProvider.isDarkMode
                        ? AppColors.secondryScaffold
                        : const Color(0xffE8F3F1),
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 40,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                settings: RouteSettings(
                                    arguments: getCurrentProduct.id),
                                builder: ((context) =>
                                    const ProductDetailsView()),
                              ),
                            );
                          },
                          child: Image.asset(AppImages.paecmental)),
                    ),
                    IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 130, left: 5),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(getCurrentProduct.title,
                                    style: titleTextStyle),
                                const Text(
                                  "20 Pcs",
                                  style: TextStyle(
                                      color: AppColors.secondryLight,
                                      fontSize: 11,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${getCurrentProduct.price.toString()}\$",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 110,
                      top: 150,
                      child: IconButton(
                          onPressed: () {
                            wishlistProvider.addOrRemoveProductFromWishList(
                                productID: getCurrentProduct.id);
                          },
                          icon: wishlistProvider.isProductInWishList(
                                  productID: getCurrentProduct.id)
                              ? const Icon(IconlyBold.heart)
                              : const Icon(IconlyLight.heart),
                          color: wishlistProvider.isProductInWishList(
                                  productID: getCurrentProduct.id)
                              ? Colors.red
                              : AppColors.secondryLight),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
