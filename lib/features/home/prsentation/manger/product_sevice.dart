import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medcs/features/home/data/models/product_model.dart';

class ProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');

  Future<void> addProduct(ProductsModel product) async {
    await productCollection.add({
      'name': product.title,
      'price': product.price,
      'description': product.description,
      'image': product.image,
      'qunatity': product.quantity
    });
  }
}
