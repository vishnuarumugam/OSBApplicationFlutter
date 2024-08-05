import '../../app.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9GXl4WmJu-FGF5y1pKXLCCeUqq8Jvo1U',
    appId: '1:872420854659:android:a1c8170aec731ff78644b6',
    messagingSenderId: '872420854659',
    projectId: 'omsaravanabhavanmobile',
    storageBucket: 'omsaravanabhavanmobile.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgJhSmWdbknvkxx-6qrDSvHgXucWJRuTc',
    appId: '1:872420854659:ios:57e8cfef3099795a8644b6',
    messagingSenderId: '872420854659',
    projectId: 'omsaravanabhavanmobile',
    storageBucket: 'omsaravanabhavanmobile.appspot.com',
    iosBundleId: 'com.example.omSaravanaBhavanApplication',
  );
}
