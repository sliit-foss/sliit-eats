import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9O7prvAYSWJ7F3PAASdEheHZ_G8oh0tk',
    appId: '1:867257560155:android:6e7d41a2e9bcecef67637e',
    messagingSenderId: '867257560155',
    projectId: 'sliit-eats',
    storageBucket: 'sliit-eats.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAE_djCP3WudOllCIObwTK7PDpvZIIE4g',
    appId: '1:867257560155:ios:733f46fd5711c0a067637e',
    messagingSenderId: '867257560155',
    projectId: 'sliit-eats',
    storageBucket: 'sliit-eats.appspot.com',
    iosClientId: '867257560155-2qf101m57t3anp5thggdlth3ie03hole.apps.googleusercontent.com',
    iosBundleId: 'com.example.sliitEats',
  );
}
