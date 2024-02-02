import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/constent/app_constant.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/product/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/views/product_details_view.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:medcs/features/home/prsentation/widgets/upload_prescription_card.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/search/presentation/views/search_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

ScrollController _scrollController = ScrollController();

double _opacity = 1;

class _HomeViewState extends State<HomeView> {
  @override
  // The initState method is called exactly once and then never again.
// It must be defined as part of the State class in a StatefulWidget.
  void initState() {
    // Always call super.initState() first.
    super.initState();

    // Initialize _opacity to 1. This means the widget starts fully visible.
    _opacity = 1;

    // Add a listener to _scrollController. This listener is a function that gets
    // called whenever the user scrolls.
    _scrollController.addListener(() {
      // Check if the user is scrolling up or down.
      // ScrollDirection.reverse means the user is scrolling down.
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // If the user is scrolling down, call setState to rebuild the widget tree.
        // Set _opacity to 0, which means the widget becomes fully transparent.
        if (mounted) {
          setState(() {
            _opacity = 0;
          });
        }
      }

      // ScrollDirection.forward means the user is scrolling up.
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // If the user is scrolling up, call setState to rebuild the widget tree.
        // Set _opacity to 1, which means the widget becomes fully visible again.
        if (mounted) {
          setState(() {
            _opacity = 1;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {}); // Remove the scroll listener
    // Cancel any timers (replace _timer with your timer variable)
    super.dispose();
  }

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              IconlyLight.buy,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                        style: StylesDark.bodyMeduim15,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 2),
                      opacity: _opacity,
                      child: const CustomUploadPrescriptionCard(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: DynamicHeightGridView(
                      builder: (context, index) => ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        child: CustomProductCard(
                          productId: productProvider.getProducts[index].id,
                        ),
                      ),
                      itemCount: productProvider.getProducts.length,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCategoryRounded extends StatelessWidget {
  const CustomCategoryRounded(
      {super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(arguments: name),
            builder: ((context) => const SearchView()),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30, top: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 1,
                      color: themeProvider.isDarkMode
                          ? AppColors.secondryScaffold
                          : const Color(0xffE8F3F1))),
              child: CircleAvatar(
                  backgroundColor: themeProvider.isDarkMode
                      ? AppColors.secondryScaffold
                      : AppColors.scaffoldLightMode,
                  radius: 25,
                  child: SvgPicture.asset(image)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
              style: themeProvider.isDarkMode
                  ? StylesDark.bodyExtraSmall11Wite
                  : StylesLight.bodyExtraSmall11,
            )
          ],
        ),
      ),
    );
  }
}
