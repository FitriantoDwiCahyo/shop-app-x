// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCoKHz6vtUt6QGkQaOPI7ddyGiYiRMcnUk',
    appId: '1:578294279843:web:b743a48391be5748115916',
    messagingSenderId: '578294279843',
    projectId: 'shop-65b37',
    authDomain: 'shop-65b37.firebaseapp.com',
    storageBucket: 'shop-65b37.appspot.com',
    measurementId: 'G-WVT6ZLF2J3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJorxElH-n72an74KftuWwDt74JkeCnQQ',
    appId: '1:578294279843:android:0513e892f3c19887115916',
    messagingSenderId: '578294279843',
    projectId: 'shop-65b37',
    storageBucket: 'shop-65b37.appspot.com',
  );
}
