import 'package:flutter/material.dart';
import 'package:medcs/features/home/data/models/product_model.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_product_card.dart';
import 'package:medcs/features/search/presentation/manger/providers/product_provider.dart';
import 'package:medcs/features/search/presentation/widgets/search_field.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

TextEditingController _searchController = TextEditingController();
List<ProductsModel> productSearchList = [];

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? categoryName;

// Check if arguments is not null and is of the expected type
    if (ModalRoute.of(context)!.settings.arguments is String) {
      categoryName = ModalRoute.of(context)!.settings.arguments as String?;
    }
    final List<ProductsModel> productList = categoryName == null
        ? productProvider.getProducts
        : productProvider.findByCategory(categoryName: categoryName);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SearchFormField(
                      searchController: _searchController,
                      onChanged: (vlaue) {
                        setState(() {
                          productSearchList = productProvider.searchQuery(
                              searchText: _searchController.text,
                              passedList: productList);
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          productSearchList = productProvider.searchQuery(
                              searchText: _searchController.text,
                              passedList: productList);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_searchController.text.isNotEmpty && productList.isEmpty) ...[
              const Center(
                  child: Text(
                'No Result Found',
                style: TextStyle(fontSize: 40, color: Colors.black),
              ))
            ],
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DynamicHeightGridView(
                  builder: (context, index) => CustomProductCard(
                    productId: _searchController.text.isNotEmpty
                        ? productSearchList[index].productID
                        : productList[index].productID,
                  ),
                  itemCount: _searchController.text.isNotEmpty
                      ? productSearchList.length
                      : productList.length,
                  crossAxisCount: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
