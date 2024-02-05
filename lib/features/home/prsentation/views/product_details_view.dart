import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_peovider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
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
        title: const Text(
          'Product Details',
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.buy),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(AppImages.largeParcemtal),
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
                          Text(
                            getCurrentProduct.title,
                            style: themeProvider.isDarkMode
                                ? StylesDark.titleRegualar22White
                                : StylesLight.titleRegualar22,
                          ),
                          Text(
                            "${getCurrentProduct.price.toString()}\$", // Replace with the actual price
                            style: themeProvider.isDarkMode
                                ? StylesDark.titleRegualar22White
                                : StylesLight.titleRegualar22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: StylesDark.bodySmall13,
                      ),
                      Text(
                        getCurrentProduct.description,
                        style: const TextStyle(fontSize: 16),
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
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          cartProvider.isProductInCart(
                                  productID: getCurrentProduct.id)
                              ? Icons.check
                              : IconlyLight.buy,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomPrimaryButton(
                          label: cartProvider.isProductInCart(
                                  productID: getCurrentProduct.id)
                              ? 'Product Added to your cart'
                              : 'Add to cart',
                          onPressed: () {
                            if (cartProvider.isProductInCart(
                                productID: getCurrentProduct.id)) {
                              return;
                            }
                            cartProvider.addProductToCart(
                                productID: getCurrentProduct.id);
                          },
                          color: AppColors.primaryColor,
                          borderRadius: 15,
                          height: 50,
                          width: 266,
                          borderColor: AppColors.primaryColor,
                          labelColor: Colors.white,
                          fontSize: 16)
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
