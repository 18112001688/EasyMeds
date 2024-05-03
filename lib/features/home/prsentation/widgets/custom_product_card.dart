import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/favourite/presentation/manger/wishlist_provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/views/product_details_view.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:provider/provider.dart';

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
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const ProductDetailsView(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                                settings: RouteSettings(
                                    arguments: getCurrentProduct.productID),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.only(bottom: 120),
                            child: Image.network(
                              getCurrentProduct.productImage,
                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                    IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 130, left: 5),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(getCurrentProduct.productTitle,
                                    style: titleTextStyle),
                                Text(
                                  getCurrentProduct.productQuantity,
                                  style: const TextStyle(
                                      color: AppColors.secondryLight,
                                      fontSize: 11,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${getCurrentProduct.productPrice.toString()}\$",
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
                          onPressed: () async {
                            // wishlistProvider.addOrRemoveProductFromWishList(
                            //     productID: getCurrentProduct.productID);
                            try {
                              if (wishlistProvider.getWishListItems
                                  .containsKey(productId)) {
                                wishlistProvider.removeOneItemFromFirebase(
                                    wishListID: wishlistProvider
                                        .getWishListItems[productId]!
                                        .wishListID,
                                    productID: productId);
                              } else {
                                wishlistProvider.addToWishListFirebase(
                                    productID: productId, context: context);
                              }
                              await wishlistProvider.fetchWishList();
                            } catch (e) {
                              rethrow;
                            }
                          },
                          icon: wishlistProvider.isProductInWishList(
                                  productID: getCurrentProduct.productID)
                              ? const Icon(IconlyBold.heart)
                              : const Icon(IconlyLight.heart),
                          color: wishlistProvider.isProductInWishList(
                                  productID: getCurrentProduct.productID)
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
