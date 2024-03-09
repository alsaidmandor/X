import 'package:firebase_auth/firebase_auth.dart';
import 'package:x/core/networking/firebase_constsnts.dart';
import 'package:x/core/networking/firebase_result.dart';

class LoginRepo {
  Future<FirebaseResult<UserCredential>> login(
      {required String email, required String password}) async {
    try {
      var response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return FirebaseResult.success(response);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(e);
    }
  }
}
