import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';

class ProductSearchBar extends StatefulWidget {
  const ProductSearchBar({Key? key}) : super(key: key);

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.068,
      width: MediaQuery.of(context).size.width * 0.77,
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF5F6FA),
          hintText: 'Search..',
          hintStyle: StylesDark.bodyMeduim15,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.secondryLight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        onChanged: (value) {
          // Handle search input changes here
          // Example: Filter product list based on the search query
        },
      ),
    );
  }
}
