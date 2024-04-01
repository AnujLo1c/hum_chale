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
    apiKey: 'AIzaSyDdMmgazhxgIJgDg_ubl0eej9t5OVs5paI',
    appId: '1:574082685128:web:4ff276fae71725d287edfd',
    messagingSenderId: '574082685128',
    projectId: 'humchalena-84f19',
    authDomain: 'humchalena-84f19.firebaseapp.com',
    storageBucket: 'humchalena-84f19.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAusgK99EtgtDy8E6TGjZ0_1W4qngXTejQ',
    appId: '1:574082685128:android:d693eefd90e79fc987edfd',
    messagingSenderId: '574082685128',
    projectId: 'humchalena-84f19',
    storageBucket: 'humchalena-84f19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6EHYgTnef9o0Gashdk2hK0AWyb3mhY-o',
    appId: '1:574082685128:ios:32a989cdc76feb8b87edfd',
    messagingSenderId: '574082685128',
    projectId: 'humchalena-84f19',
    storageBucket: 'humchalena-84f19.appspot.com',
    iosBundleId: 'com.example.humChale',
  );
}