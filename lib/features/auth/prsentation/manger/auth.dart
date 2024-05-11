import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthSevice {
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Access user information
    final user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (!userDoc.exists) {
      // Add user data to Firestore
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "userID": user.uid,
        "userName": user.displayName ?? "",
        "userEmail": user.email ?? "",
        "userImage": user.photoURL ?? "",
        "createdAt": Timestamp.now(),
        "userWish": [],
        "userCart": []
      });
    }

    return userCredential;
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    // Access user information
    final user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (!userDoc.exists) {
      // Add user data to Firestore
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "userID": user.uid,
        "userName": user.displayName ?? "",
        "userEmail": user.email ?? "",
        "userImage": user.photoURL ?? "",
        "createdAt": Timestamp.now(),
        "userWish": [],
        "userCart": []
      });
    }
    // Once signed in, return the UserCredential
    return userCredential;
  }
}
