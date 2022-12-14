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
    apiKey: 'AIzaSyACEYCL1oUNsQQz_jb9K7Hw18O-cJy81ug',
    appId: '1:271382473784:web:0ff97d8b2063e25111cacd',
    messagingSenderId: '271382473784',
    projectId: 'hamronovel',
    authDomain: 'hamronovel.firebaseapp.com',
    storageBucket: 'hamronovel.appspot.com',
    measurementId: 'G-YWYVVRW6YS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUsbmW5iAHdoFF4Y_ENcIZUgKCAJj0qWs',
    appId: '1:271382473784:android:2b0711924ce6096111cacd',
    messagingSenderId: '271382473784',
    projectId: 'hamronovel',
    storageBucket: 'hamronovel.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxHOTvCuyu_mes2oSTnPuBa08c-B9YV08',
    appId: '1:271382473784:ios:f56c9755cc90919911cacd',
    messagingSenderId: '271382473784',
    projectId: 'hamronovel',
    storageBucket: 'hamronovel.appspot.com',
    iosClientId: '271382473784-lca6lf7ts1grfn01jfh8gjdub3d8s7va.apps.googleusercontent.com',
    iosBundleId: 'com.example.books',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxHOTvCuyu_mes2oSTnPuBa08c-B9YV08',
    appId: '1:271382473784:ios:f56c9755cc90919911cacd',
    messagingSenderId: '271382473784',
    projectId: 'hamronovel',
    storageBucket: 'hamronovel.appspot.com',
    iosClientId: '271382473784-lca6lf7ts1grfn01jfh8gjdub3d8s7va.apps.googleusercontent.com',
    iosBundleId: 'com.example.books',
  );
}
