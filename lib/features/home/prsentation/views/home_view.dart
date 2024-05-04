import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/app_constant.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_rounded_category.dart';
import 'package:medcs/features/home/prsentation/widgets/upload_prescription_card.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: themeProvider.isDarkMode
              ? const Icon(Icons.menu)
              : SvgPicture.asset(AppImages.menu),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Hello',
                        style: themeProvider.isDarkMode
                            ? StylesDark.titleHeading34White
                            : StylesLight.titleHeading34,
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Welcome To',
                        style: StylesDark.bodyLarge17,
                      ),
                      Text(
                        ' EasyMeds',
                        style: TextStyle(
                          color: AppColors.secondryLight,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12, top: 10, bottom: 20),
                    child: CustomUploadPrescriptionCard(),
                  ),
                  Row(children: [
                    Text(
                      'Categories',
                      style: themeProvider.isDarkMode
                          ? StylesDark.titleRegualar22White
                          : StylesLight.titleRegualar22,
                    )
                  ]),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    children: List.generate(
                      AppConstent.categoriesList.length,
                      (index) => CustomCategoryRounded(
                        image: AppConstent.categoriesList[index].image,
                        name: AppConstent.categoriesList[index].categoryName,
                      ),
                    ),
                  ),
                  DynamicHeightGridView(
                    builder: (context, index) => ChangeNotifierProvider.value(
                      value: productProvider.getProducts[index],
                      child: CustomProductCard(
                        productId: productProvider.getProducts[index].productID,
                      ),
                    ),
                    itemCount: productProvider.getProducts.length,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
