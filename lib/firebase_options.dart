// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBNEDxcCJi-odV4og4UrX1YptJfRr70W0o',
    appId: '1:223178606994:web:c879d38c730885821a594b',
    messagingSenderId: '223178606994',
    projectId: 'easymeds-database',
    authDomain: 'easymeds-database.firebaseapp.com',
    storageBucket: 'easymeds-database.appspot.com',
    measurementId: 'G-Q5F7F1MBD4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRoNmEarVA9KN0cYXPoneUrhpIQsyCmRU',
    appId: '1:223178606994:android:cae7124fb743e9271a594b',
    messagingSenderId: '223178606994',
    projectId: 'easymeds-database',
    storageBucket: 'easymeds-database.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdb6Pb9YlBlbn-WvtUIk9WD9k4-Y8MhPI',
    appId: '1:223178606994:ios:1a22fb11612c52b21a594b',
    messagingSenderId: '223178606994',
    projectId: 'easymeds-database',
    storageBucket: 'easymeds-database.appspot.com',
    iosBundleId: 'com.example.medcs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdb6Pb9YlBlbn-WvtUIk9WD9k4-Y8MhPI',
    appId: '1:223178606994:ios:e1ac400a0f3027801a594b',
    messagingSenderId: '223178606994',
    projectId: 'easymeds-database',
    storageBucket: 'easymeds-database.appspot.com',
    iosBundleId: 'com.example.medcs.RunnerTests',
  );
}
