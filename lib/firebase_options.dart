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
    apiKey: 'AIzaSyAwXoyDZFGYQ5o2OBoQHRiLpoQawmK9uKQ',
    appId: '1:374106020292:web:b28a9e7acc3cbb44752c91',
    messagingSenderId: '374106020292',
    projectId: 'apnibook-de300',
    authDomain: 'apnibook-de300.firebaseapp.com',
    storageBucket: 'apnibook-de300.appspot.com',
    measurementId: 'G-PSGZ36GD74',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcBTLFBz0tBCBHEoPxWARJRFz4bU8DIqY',
    appId: '1:374106020292:android:552cd7338d9dbd4d752c91',
    messagingSenderId: '374106020292',
    projectId: 'apnibook-de300',
    storageBucket: 'apnibook-de300.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnDr4yXqRih4bc9W3qDEelA1igkibU9bk',
    appId: '1:374106020292:ios:bf94bf110daba25d752c91',
    messagingSenderId: '374106020292',
    projectId: 'apnibook-de300',
    storageBucket: 'apnibook-de300.appspot.com',
    iosClientId: '374106020292-q66f1d8pcvh4cohsp313qavl1pmemjfv.apps.googleusercontent.com',
    iosBundleId: 'com.example.apnibook',
  );
}
