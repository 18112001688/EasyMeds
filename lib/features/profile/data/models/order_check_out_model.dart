import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutOrder {
  final String userID;
  final String userName;
  final String userEmail;
  final String userImage;
  final String deliveryAddress;
  final String totalItems;
  final String getTotal;
  final List<Map<String, dynamic>> items;
  final String productImage;
  final String productName;

  CheckoutOrder(
      {required this.userID,
      required this.userName,
      required this.userEmail,
      required this.userImage,
      required this.deliveryAddress,
      required this.totalItems,
      required this.getTotal,
      required this.items,
      required this.productImage,
      required this.productName});

  factory CheckoutOrder.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // Assuming 'items' is a List<Map<String, dynamic>> containing product information
    List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(data['items']);

    // Extracting productImage from the first item in the list (assuming it's the same for all items)
    String productImage =
        items.isNotEmpty ? items[0]['productImage'] ?? '' : '';
    String productName = items.isNotEmpty ? items[0]['productName'] ?? '' : '';

    return CheckoutOrder(
        userID: data['userID'],
        userName: data['userName'],
        userEmail: data['userEmail'],
        userImage: data['userImage'],
        deliveryAddress: data['deliveryAddress'],
        totalItems: data['totalItems'],
        getTotal: data['getTotal'],
        items: List<Map<String, dynamic>>.from(data['items']),
        productImage: productImage,
        productName: productName);
  }
}
