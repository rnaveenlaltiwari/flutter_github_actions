import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_actions/main.dart';

void main() async {
  await runMainApp(firebaseOptions: DefaultFirebaseOptions.currentPlatform);
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'AIzaSyDadGFfZX87AqjZ5QiqR36qIyhYpvAfwYg',
          appId: '1:922586843536:android:896bcd3c5adb993b134b15',
          messagingSenderId: '922586843536',
          projectId: 'bookmark-my-benefits',
          storageBucket: 'bookmark-my-benefits.firebasestorage.app',
        );
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        throw UnsupportedError('Fuchsia not supported');
      default:
        throw UnsupportedError('Unknown platform');
    }
  }
}
