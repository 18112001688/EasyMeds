import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/manger/cart_Provider/cart_provider.dart';
import 'package:medcs/features/cart/presentation/views/delivery_address_view.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.addressSent});

  final String addressSent;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late String address;

  @override
  void initState() {
    super.initState();
    address = widget.addressSent;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? AppColors.scaffoldDarkMode
            : Colors.white,
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Deleviery Address',
                      style: themeProvider.isDarkMode
                          ? StylesDark.bodyLarge17White
                          : StylesLight.bodyLarge17,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Navigate to DeliveryAddressView and handle returned address
                        final newAddress = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeliveryAdressView(),
                          ),
                        );
                        if (newAddress != null) {
                          setState(() {
                            address = newAddress;
                          });
                        } // Update address in parent widget
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      address,
                      style: const TextStyle(
                          color: AppColors.secondryLight, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Order Info',
              style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.white
                      : AppColors.secondryBlack,
                  fontSize: 17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal',
                    style: TextStyle(
                      color: AppColors.secondryLight,
                    )),
                Text(
                  '\$20',
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : AppColors.secondryBlack),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping cost',
                  style: StylesLight.bodyMeduimGrey15,
                ),
                Text(
                  '\$20',
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : AppColors.secondryBlack),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Total items (${cartProvider.getCartItem.length})',
                  style: const TextStyle(color: AppColors.secondryLight),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${cartProvider.getTotal(productProvider: productProvider)}',
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : AppColors.secondryBlack),
                ),
                const Spacer(),
                CustomPrimaryButton(
                  label: 'Checkout',
                  onPressed: () {},
                  color: AppColors.primaryColor,
                  borderRadius: 14,
                  height: 40,
                  width: 150,
                  borderColor: AppColors.primaryColor,
                  labelColor: Colors.white,
                  fontSize: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
