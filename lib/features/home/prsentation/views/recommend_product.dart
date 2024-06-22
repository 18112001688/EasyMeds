import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedProductView extends StatelessWidget {
  const RecommendedProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User is not logged in, show message or redirect to login screen
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recommended Products',
            style: themeProvider.isDarkMode
                ? StylesDark.bodyLarge17White
                : StylesLight.bodyLarge17,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    'Please log in to view recommended products.',
                    style: themeProvider.isDarkMode
                        ? StylesDark.bodyMeduim15
                        : StylesLight.bodyMeduim15,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/LoginView');
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      );
    } else {
      // User is logged in, fetch and display recommended products
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recommended Product',
            style: themeProvider.isDarkMode
                ? StylesDark.bodyLarge17White
                : StylesLight.bodyLarge17,
          ),
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('productCategory', isEqualTo: 'beauty')
              .get(), // Fetch beauty products
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.docs.isEmpty) {
              // Check if docs list is empty
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No recommended beauty products available',
                      style: themeProvider.isDarkMode
                          ? StylesDark.titleRegualar22
                          : StylesLight.titleRegualar22,
                    ),
                  ],
                ),
              );
            } else {
              final beautyProducts = snapshot.data!.docs;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: DynamicHeightGridView(
                    builder: (context, index) {
                      final product = beautyProducts[index].data();
                      return CustomProductCard(
                        productId: product[
                            'productID'], // Adjust according to your data structure
                      );
                    },
                    itemCount: beautyProducts.length,
                    crossAxisCount: 2,
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  }
}
