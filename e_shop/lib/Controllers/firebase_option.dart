import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:449888893960:ios:490faa1702bf5a13cd65bd',
        apiKey: 'AIzaSyA0IkQR44f06y89O7Ko25ablGHXDIHUE_0',
        projectId: 'e-shop-265db',
        messagingSenderId: '449888893960',
        iosBundleId: 'TCI.app.eShop',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:449888893960:android:7cfe00229688575ecd65bd',
        apiKey: 'AIzaSyDKk4KmzoL83IF3tqU6s7wB6dFs8T4LWng',
        projectId: 'e-shop-265db',
        messagingSenderId: '449888893960',
      );
    }
  }
}
