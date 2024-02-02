import 'package:flutter/material.dart';
import 'package:medcs/features/home/data/models/product_model.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  List<ProductsModel> get getProducts {
    return _products;
  }

  ProductsModel? findByProductID(String productID) {
    // Check if there are any products with the specified ID
    if (_products.where((element) => element.id == productID).isEmpty) {
      return null;
    }
    // Return the first product found with the specified ID
    return _products.firstWhere((element) => element.id == productID);
  }

  List<ProductsModel> findByCategory({required String categoryName}) {
    List<ProductsModel> ctgList = _products
        .where((element) =>
            element.category.toLowerCase().contains(categoryName.toLowerCase()))
        .toList();

    return ctgList;
  }

  final List<ProductsModel> _products = [
    ProductsModel(
      title: "Paracetamol",
      price: 15.99,
      description:
          "Paracetamol is a widely used pain reliever known for its effectiveness in reducing mild to moderate pain and fever. Each package contains 20 tablets, making it a convenient choice for managing various discomforts.",
      quantity: 20,
      image: "path_to_paracetamol_image",
      id: const Uuid().v4(),
      category: "Medicine",
    ),
    ProductsModel(
      title: "Aspirin",
      price: 9.99,
      description:
          "Aspirin is a classic pain reliever that also acts as an anti-inflammatory agent. With 30 tablets per pack, it provides reliable relief for headaches and other minor aches and pains.",
      quantity: 30,
      image: "path_to_aspirin_image",
      id: const Uuid().v4(),
      category: "Medicine",
    ),
    ProductsModel(
      title: "Vitamin C",
      price: 12.99,
      description:
          "Boost your immune system with Vitamin C supplements. Packed with 60 tablets, this supplement supports overall health and helps strengthen your body's defenses against infections.",
      quantity: 60,
      image: "path_to_vitamin_c_image",
      id: const Uuid().v4(),
      category: "Supplement",
    ),
    ProductsModel(
      title: "Cough Syrup",
      price: 8.49,
      description:
          "Find relief from cough and throat irritation with this effective cough syrup. Each bottle contains 15 doses, providing soothing relief and promoting a good night's sleep.",
      quantity: 15,
      image: "path_to_cough_syrup_image",
      id: const Uuid().v4(),
      category: "Medicine",
    ),
    ProductsModel(
      title: "Band-Aids",
      price: 5.99,
      description:
          "Essential for every first aid kit, these Band-Aids are designed for wound care. With 50 adhesive strips per box, they offer protection and promote healing for minor cuts and abrasions.",
      quantity: 50,
      image: "path_to_band_aids_image",
      id: const Uuid().v4(),
      category: "Medical Supplies",
    ),
    ProductsModel(
      title: "Omega-3 Supplement",
      price: 18.99,
      description:
          "Support heart health and cognitive function with Omega-3 supplements. Each bottle contains 30 capsules, providing a rich source of essential fatty acids for overall well-being.",
      quantity: 30,
      image: "path_to_omega3_image",
      id: const Uuid().v4(),
      category: "Supplement",
    ),
    ProductsModel(
      title: "Hand Sanitizer",
      price: 3.99,
      description:
          "Maintain good hygiene on the go with this antibacterial hand sanitizer. The compact size with 10 uses per bottle makes it perfect for personal care, ensuring clean hands anytime, anywhere.",
      quantity: 10,
      image: "path_to_hand_sanitizer_image",
      id: const Uuid().v4(),
      category: "Personal Care",
    ),
    ProductsModel(
      title: "Multivitamin",
      price: 14.49,
      description:
          "Promote overall health and fill nutritional gaps with these multivitamin supplements. With 90 tablets per bottle, they provide a comprehensive blend of vitamins and minerals for daily wellness.",
      quantity: 90,
      image: "path_to_multivitamin_image",
      id: const Uuid().v4(),
      category: "Supplement",
    ),
    ProductsModel(
      title: "Thermometer",
      price: 19.99,
      description:
          "Keep track of your body temperature with this digital thermometer. With a pack of 5, it's a reliable tool for monitoring health and detecting fever symptoms.",
      quantity: 5,
      image: "path_to_thermometer_image",
      id: const Uuid().v4(),
      category: "Medical Supplies",
    ),
    ProductsModel(
      title: "Pain Relief Gel",
      price: 7.99,
      description:
          "Target localized pain with this topical pain relief gel. With 25 applications per tube, it offers quick and effective relief for muscle aches and joint discomfort.",
      quantity: 25,
      image: "path_to_pain_relief_gel_image",
      id: const Uuid().v4(),
      category: "Medicine",
    ),
  ];
}
