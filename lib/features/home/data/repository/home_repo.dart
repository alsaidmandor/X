import 'package:firebase_auth/firebase_auth.dart';
import 'package:x/core/helper/cache_helper.dart';

import '../../../../core/networking/firebase_constsnts.dart';
import '../../../../core/networking/firebase_result.dart';
import '../../../sign_up/data/models/user_model.dart';

class HomeRepo {
  Future<FirebaseResult<UserModel>> getProfile() async {
    final uId = CacheHelper.getData(key: 'uId');
    try {
      var response = await database
          .collection(FirebaseConstants.profile)
          .doc(uId)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
      return FirebaseResult.success(response);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(e);
    }
  }
}
