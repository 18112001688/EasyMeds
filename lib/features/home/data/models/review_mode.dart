import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String productId;
  final double rating;
  final String review;
  final String userName;
  final String userImage;
  final Timestamp reviewDate; // Change type to DateTime
  // Change type to DateTime

  ReviewModel(
      {required this.rating,
      required this.reviewDate,
      required this.productId,
      required this.review,
      required this.userName,
      required this.userImage});

  factory ReviewModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return ReviewModel(
      productId: data['ProductID'],
      rating: data['Rating'],
      review: data['Review'],
      userName: data['UserName'],
      userImage: data['userImage'],
      reviewDate: data['ReviewDate'],
    );
  }
}
