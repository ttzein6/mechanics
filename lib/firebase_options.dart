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
        return windows;
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
    apiKey: 'AIzaSyDc242ttPah2TLZJpHwVaHUv_rsvN2E9H0',
    appId: '1:1000569039593:web:410ed3c659145ad44b1e78',
    messagingSenderId: '1000569039593',
    projectId: 'mechanics-adel',
    authDomain: 'mechanics-adel.firebaseapp.com',
    storageBucket: 'mechanics-adel.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcgJAvm6Lw0fzNiNaJRRPm9OJpSWD9bZU',
    appId: '1:1000569039593:android:8a53fd7960f6479a4b1e78',
    messagingSenderId: '1000569039593',
    projectId: 'mechanics-adel',
    storageBucket: 'mechanics-adel.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9b17Oafj_9GELjhkPaV1zkrnMYjBbVds',
    appId: '1:1000569039593:ios:eb947f1aebda8fe54b1e78',
    messagingSenderId: '1000569039593',
    projectId: 'mechanics-adel',
    storageBucket: 'mechanics-adel.appspot.com',
    iosBundleId: 'com.example.mechanics',
  );
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDc242ttPah2TLZJpHwVaHUv_rsvN2E9H0',
    appId: '1:1000569039593:web:410ed3c659145ad44b1e78',
    messagingSenderId: '1000569039593',
    projectId: 'mechanics-adel',
    authDomain: 'mechanics-adel.firebaseapp.com',
    storageBucket: 'mechanics-adel.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9b17Oafj_9GELjhkPaV1zkrnMYjBbVds',
    appId: '1:1000569039593:ios:eb947f1aebda8fe54b1e78',
    messagingSenderId: '1000569039593',
    projectId: 'mechanics-adel',
    storageBucket: 'mechanics-adel.appspot.com',
    iosBundleId: 'com.example.mechanics',
  );
}
