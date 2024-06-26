import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/data/models/cart_model.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_quantity.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:provider/provider.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cartModelProvider = context.watch<CartModel>();
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartProvider>();

    final getCurrentProduct =
        productProvider.findByProductID(cartModelProvider.productID);
    return getCurrentProduct == null
        ? const Text('No Products fonund')
        : Container(
            height: 120,
            width: 330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeProvider.isDarkMode
                    ? AppColors.scaffoldDarkMode
                    : const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    // Inner shadow
                    color: themeProvider.isDarkMode
                        ? AppColors.scaffoldDarkMode
                        : const Color.fromARGB(
                            255, 238, 238, 238), // Subtle grey shadow
                    offset: const Offset(0.0, 1.0), // Slight offset down
                    blurRadius: 4.0, // Blur radius
                    spreadRadius: 2.0, // No spread
                  ),
                  BoxShadow(
                    // Inner shadow
                    color: themeProvider.isDarkMode
                        ? AppColors.scaffoldDarkMode
                        : const Color.fromARGB(
                            255, 238, 238, 238), // Subtle grey shadow
                    offset: const Offset(0.0, 1.0), // Slight offset down
                    blurRadius: 4.0, // Blur radius
                    spreadRadius: 2.0, // No spread
                  ),
                ],
                border: Border.all(
                    color: themeProvider.isDarkMode
                        ? AppColors.secondryScaffold
                        : Colors.white)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: themeProvider.isDarkMode
                              ? AppColors.secondryScaffold
                              : const Color(0xffE8F3F1),
                          width: 2,
                        )),
                    child: CachedNetworkImage(
                      imageUrl: getCurrentProduct.productImage,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Failed to load image',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            getCurrentProduct.productTitle,
                            style: themeProvider.isDarkMode
                                ? StylesDark.bodyLarge17
                                : StylesLight.bodyLarge17,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Text(
                            "\$${getCurrentProduct.productPrice}",
                            style: const TextStyle(
                                color: AppColors.secondryLight, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: CustomQuantity(
                            qunatity: cartModelProvider.quantity,
                            cartModel: cartModelProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        cartProvider.removeOneItemFromFirebase(
                            productName: cartModelProvider.productName,
                            cartID: cartModelProvider.cartID,
                            productID: getCurrentProduct.productID,
                            quantity: cartModelProvider.quantity,
                            productImage: cartModelProvider.productImage);
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xffADADAD),
                      ))
                ],
              ),
            ),
          );
  }
}
