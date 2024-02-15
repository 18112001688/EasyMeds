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
  // final List<ProductsModel> _products = [
  //   ProductsModel(
  //     title: "Paracetamol",
  //     price: 15.99,
  //     description:
  //         "Paracetamol is a widely used pain reliever known for its effectiveness in reducing mild to moderate pain and fever. Each package contains 20 tablets, making it a convenient choice for managing various discomforts.",
  //     quantity: 20,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "basic",
  //   ),
  //   ProductsModel(
  //     title: "Aspirin",
  //     price: 9.99,
  //     description:
  //         "Aspirin is a classic pain reliever that also acts as an anti-inflammatory agent. With 30 tablets per pack, it provides reliable relief for headaches and other minor aches and pains.",
  //     quantity: 30,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "basic",
  //   ),
  //   ProductsModel(
  //     title: "Vitamin C",
  //     price: 12.99,
  //     description:
  //         "Boost your immune system with Vitamin C supplements. Packed with 60 tablets, this supplement supports overall health and helps strengthen your body's defenses against infections.",
  //     quantity: 60,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "Supplement",
  //   ),
  //   ProductsModel(
  //     title: "Cough Syrup",
  //     price: 8.49,
  //     description:
  //         "Find relief from cough and throat irritation with this effective cough syrup. Each bottle contains 15 doses, providing soothing relief and promoting a good night's sleep.",
  //     quantity: 15,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "Supplements",
  //   ),
  //   ProductsModel(
  //     title: "Band-Aids",
  //     price: 5.99,
  //     description:
  //         "Essential for every first aid kit, these Band-Aids are designed for wound care. With 50 adhesive strips per box, they offer protection and promote healing for minor cuts and abrasions.",
  //     quantity: 50,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "Family",
  //   ),
  //   ProductsModel(
  //     title: "Omega-3 Supplement",
  //     price: 18.99,
  //     description:
  //         "Support heart health and cognitive function with Omega-3 supplements. Each bottle contains 30 capsules, providing a rich source of essential fatty acids for overall well-being.",
  //     quantity: 30,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "Supplements",
  //   ),
  //   ProductsModel(
  //     title: "beauty",
  //     price: 3.99,
  //     description:
  //         "Maintain good hygiene on the go with this antibacterial hand sanitizer. The compact size with 10 uses per bottle makes it perfect for personal care, ensuring clean hands anytime, anywhere.",
  //     quantity: 10,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "beauty",
  //   ),
  //   ProductsModel(
  //     title: "Multivitamin",
  //     price: 14.49,
  //     description:
  //         "Promote overall health and fill nutritional gaps with these multivitamin supplements. With 90 tablets per bottle, they provide a comprehensive blend of vitamins and minerals for daily wellness.",
  //     quantity: 90,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "LifeStyle",
  //   ),
  //   ProductsModel(
  //     title: "Thermometer",
  //     price: 19.99,
  //     description:
  //         "Keep track of your body temperature with this digital thermometer. With a pack of 5, it's a reliable tool for monitoring health and detecting fever symptoms.",
  //     quantity: 5,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "LifeStyle",
  //   ),
  //   ProductsModel(
  //     title: "Pain Relief Gel",
  //     price: 7.99,
  //     description:
  //         "Target localized pain with this topical pain relief gel. With 25 applications per tube, it offers quick and effective relief for muscle aches and joint discomfort.",
  //     quantity: 25,
  //     image: AppImages.paecmental,
  //     id: const Uuid().v4(),
  //     category: "Health",
  //   ),
  // ];
}
