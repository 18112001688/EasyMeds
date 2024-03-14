import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcs/features/home/data/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductsModel> _products = [];
  List<ProductsModel> get getProducts {
    return _products;
  }

  ProductsModel? findByProductID(String productID) {
    // Check if there are any products with the specified ID
    if (_products.where((element) => element.productID == productID).isEmpty) {
      return null;
    }
    // Return the first product found with the specified ID
    return _products.firstWhere((element) => element.productID == productID);
  }

  List<ProductsModel> findByCategory({required String categoryName}) {
    List<ProductsModel> ctgList = _products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();

    return ctgList;
  }

// Function to filter products based on a search text.
  List<ProductsModel> searchQuery(
      {required String searchText, required List<ProductsModel> passedList}) {
    // Using the `where` method to filter the list of products (_products).
    // The condition checks if the lowercase title of each product contains the lowercase searchText.
    List<ProductsModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    // Returning the filtered list of products.
    return searchList;
  }

  final productDB = FirebaseFirestore.instance.collection('products');
  Future<List<ProductsModel>> fetchProducts() async {
    try {
      await productDB.get().then((productSnapShot) {
        _products.clear();
        for (var element in productSnapShot.docs) {
          _products.insert(0, ProductsModel.fromFireStore(element));
        }
      });
      notifyListeners();
      return _products;
    } catch (error) {
      rethrow;
    }
  }

  Stream<List<ProductsModel>> fetchProductStream() {
    try {
      return productDB.snapshots().map((snapShot) {
        _products.clear();
        for (var element in snapShot.docs) {
          _products.insert(0, ProductsModel.fromFireStore(element));
        }
        return _products;
      });
    } catch (e) {
      rethrow;
    }
  }
}
