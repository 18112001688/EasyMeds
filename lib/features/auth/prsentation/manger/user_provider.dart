import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medcs/features/auth/data/model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel {
    return userModel;
  }

  Future<UserModel?> fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    var uid = user.uid;

    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userDocMap = userDoc.data();
      userModel = UserModel(
        userID: userDoc.get("userID"),
        userName: userDoc.get('userName'),
        userImage: userDoc.get('userImage'),
        userEmail: userDoc.get('userEmail'),
        createdAt: userDoc.get("createdAt"),
        userCart:
            userDocMap!.containsKey("userCart") ? userDoc.get('userCart') : [],
        userWish:
            userDocMap.containsKey("userWish") ? userDoc.get('userWish') : [],
      );
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
