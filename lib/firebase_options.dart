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
    apiKey: 'AIzaSyA54sEo5c3VOaflsdudsPZG4f_hXOTzrNw',
    appId: '1:571968842149:web:d1e037531ea4452cd7a04c',
    messagingSenderId: '571968842149',
    projectId: 'recetas-flutter-89bf2',
    authDomain: 'recetas-flutter-89bf2.firebaseapp.com',
    storageBucket: 'recetas-flutter-89bf2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmKBqZbnZsPlt0bw4NIG4GuV_OOEuHn18',
    appId: '1:571968842149:android:1c662d164e519538d7a04c',
    messagingSenderId: '571968842149',
    projectId: 'recetas-flutter-89bf2',
    storageBucket: 'recetas-flutter-89bf2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwU6djcvFfEb0b3T0Lo6Lmr-wGynpEW2Y',
    appId: '1:571968842149:ios:85d135da01f865f6d7a04c',
    messagingSenderId: '571968842149',
    projectId: 'recetas-flutter-89bf2',
    storageBucket: 'recetas-flutter-89bf2.appspot.com',
    iosBundleId: 'com.example.ac7test',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwU6djcvFfEb0b3T0Lo6Lmr-wGynpEW2Y',
    appId: '1:571968842149:ios:a4be29c156dcf807d7a04c',
    messagingSenderId: '571968842149',
    projectId: 'recetas-flutter-89bf2',
    storageBucket: 'recetas-flutter-89bf2.appspot.com',
    iosBundleId: 'com.example.ac7test.RunnerTests',
  );
}
