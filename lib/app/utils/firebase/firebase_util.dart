import '../../app.dart';

class FirebaseUtil {
  static final FirebaseUtil _firebaseUtil = FirebaseUtil._internal();

  factory FirebaseUtil() {
    return _firebaseUtil;
  }

  FirebaseUtil._internal();

  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
