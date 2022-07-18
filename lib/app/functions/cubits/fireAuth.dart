import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static void init() {
    if (auth.currentUser != null) {
      uid = auth.currentUser?.uid;
    }
  }

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static String? uid;
}
