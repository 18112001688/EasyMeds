import 'package:flutter/material.dart';
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

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
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
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DynamicHeightGridView(
                  builder: (context, index) => ChangeNotifierProvider.value(
                    value: productProvider.getProducts[index],
                    child: CustomProductCard(
                      productId: productProvider.getProducts[index].id,
                    ),
                  ),
                  itemCount: productProvider.getProducts.length,
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
