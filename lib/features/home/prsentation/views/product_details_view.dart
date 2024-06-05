import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentProduct = productProvider.findByProductID(productID);
    final themeProvider = context.watch<ThemeProvider>();
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Product Details'),
      ),
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: getCurrentProduct.productImage,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Medicine Name',
                            style: StylesDark.bodySmall13,
                          ),
                          Text('Price', // Replace with the actual price
                              style: StylesDark.bodySmall13),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              getCurrentProduct.productTitle,
                              style: themeProvider.isDarkMode
                                  ? StylesDark.bodyMeduim15
                                  : StylesLight.bodyMeduim15,
                            ),
                          ),
                          Text(
                            "${getCurrentProduct.productPrice}\$",
                            style: themeProvider.isDarkMode
                                ? StylesDark.titleRegualar22White
                                : StylesLight.titleRegualar22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Description',
                            style: StylesDark.bodySmall13,
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).push('/ReviewsView',
                                  extra: getCurrentProduct.productID);
                            },
                            child: const Text(
                              'Reviews',
                              style: TextStyle(
                                  color: AppColors.secondryOrange,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        getCurrentProduct.productDescription,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? AppColors.secondryScaffold
                              : AppColors.secondryPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          cartProvider.isProductInCart(
                                  productID: getCurrentProduct.productID)
                              ? Icons.check
                              : IconlyLight.buy,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      CustomPrimaryButton(
                        label: cartProvider.isProductInCart(
                                productID: getCurrentProduct.productID)
                            ? 'Product Added to your cart'
                            : 'Add to cart',
                        onPressed: () async {
                          if (cartProvider.isProductInCart(
                              productID: getCurrentProduct.productID)) {
                            return;
                          }
                          try {
                            await cartProvider.addToCartFirebase(
                              productImage: getCurrentProduct.productImage,
                              productName: getCurrentProduct.productTitle,
                              productID: getCurrentProduct.productID,
                              quantity: 1,
                              context: context,
                            );
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.buildSnackBar(
                                  message: e.toString(),
                                  color: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        color: AppColors.primaryColor,
                        borderRadius: 15,
                        height: 50,
                        width: 266,
                        borderColor: AppColors.primaryColor,
                        labelColor: Colors.white,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
