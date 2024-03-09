import 'package:firebase_auth/firebase_auth.dart';
import 'package:x/features/sign_up/data/models/user_model.dart';

import '../../../../core/networking/firebase_constsnts.dart';
import '../../../../core/networking/firebase_result.dart';
import '../../../../core/utilits/Utility.dart';

class SignupRepo {
  Future<FirebaseResult<UserCredential>> signUp(
      {required String email,
      required String password,
      required UserModel user}) async {
    try {
      var response = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      response.user!.updateDisplayName(user.displayName);
      response.user!.updatePhotoURL(user.profilePic);
      user.userId = response.user!.uid;
      user.key = response.user!.uid;
      createUser(user, newUser: true);
      return FirebaseResult.success(response);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(e);
    }
  }

  void createUser(UserModel user, {bool newUser = false}) {
    if (newUser) {
      // Create username by the combination of name and id
      user.userName =
          Utility.getUserName(id: user.userId!, name: user.displayName!);

      // Time at which user is created
      user.createdAt = DateTime.now().toUtc().toString();
    }

    users.doc(user.userId).set(user.toJson());
  }
}
