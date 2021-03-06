import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['SLIIT_EATS_FIREBASE_API_KEY']!,
    appId: dotenv.env['SLIIT_EATS_FIREBASE_APP_ID']!,
    messagingSenderId: dotenv.env['SLIIT_EATS_FCM_SENDER_ID']!,
    projectId: dotenv.env['SLIIT_EATS_FIREBASE_PROJECT_ID']!,
    storageBucket: dotenv.env['SLIIT_EATS_FIREBASE_BUCKET']!,
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['SLIIT_EATS_FIREBASE_API_KEY']!,
    appId: dotenv.env['SLIIT_EATS_FIREBASE_APP_ID']!,
    messagingSenderId: dotenv.env['SLIIT_EATS_FCM_SENDER_ID']!,
    projectId: dotenv.env['SLIIT_EATS_FIREBASE_PROJECT_ID']!,
    storageBucket: dotenv.env['SLIIT_EATS_FIREBASE_BUCKET']!,
    iosClientId:
        '867257560155-2qf101m57t3anp5thggdlth3ie03hole.apps.googleusercontent.com',
    iosBundleId: 'com.example.sliitEats',
  );
}
