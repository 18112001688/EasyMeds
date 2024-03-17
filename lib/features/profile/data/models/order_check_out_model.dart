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

  CheckoutOrder({
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.deliveryAddress,
    required this.totalItems,
    required this.getTotal,
    required this.items,
  });

  factory CheckoutOrder.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return CheckoutOrder(
      userID: data['userID'],
      userName: data['userName'],
      userEmail: data['userEmail'],
      userImage: data['userImage'],
      deliveryAddress: data['deliveryAddress'],
      totalItems: data['totalItems'],
      getTotal: data['getTotal'],
      items: List<Map<String, dynamic>>.from(data['items']),
    );
  }
}
