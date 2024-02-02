import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/product/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({Key? key, required this.searchController})
      : super(key: key);
  final TextEditingController searchController;

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  @override
  void dispose() {
    SearchController().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      child: TextField(
        controller: widget.searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: themeProvider.isDarkMode
              ? const Color(0xff222E34)
              : const Color(0xffF5F6FA),
          hintText: 'Search..',
          hintStyle: StylesDark.bodyMeduim15,
          prefixIcon: const Icon(
            IconlyLight.search,
            color: AppColors.secondryLight,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              widget.searchController.clear();
            },
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
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
        onSubmitted: (value) {},
      ),
    );
  }
}
