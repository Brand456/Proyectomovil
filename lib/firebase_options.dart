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
    apiKey: 'AIzaSyAsQoBnucU9BFHFi2HIJ9mcGDeKoCsnJMM',
    appId: '1:627925539838:web:50205d961cc2facc74beaf',
    messagingSenderId: '627925539838',
    projectId: 'tesisproyect-aab00',
    authDomain: 'tesisproyect-aab00.firebaseapp.com',
    databaseURL: 'https://tesisproyect-aab00-default-rtdb.firebaseio.com',
    storageBucket: 'tesisproyect-aab00.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUVlcr7II33H7Ulbev4SUmRvam5JVf01E',
    appId: '1:627925539838:android:534165325f735d7074beaf',
    messagingSenderId: '627925539838',
    projectId: 'tesisproyect-aab00',
    databaseURL: 'https://tesisproyect-aab00-default-rtdb.firebaseio.com',
    storageBucket: 'tesisproyect-aab00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4NmN6cX2PaGNChTDJqRC4_EAuRMNfKdg',
    appId: '1:627925539838:ios:47775df095a10cf274beaf',
    messagingSenderId: '627925539838',
    projectId: 'tesisproyect-aab00',
    databaseURL: 'https://tesisproyect-aab00-default-rtdb.firebaseio.com',
    storageBucket: 'tesisproyect-aab00.appspot.com',
    iosClientId: '627925539838-6rbi32qvjtq4akqbmbj3gb6p80j97blp.apps.googleusercontent.com',
    iosBundleId: 'com.example.productosApp',
  );
}
