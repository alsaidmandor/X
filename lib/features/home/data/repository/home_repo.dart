import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:x/core/helper/cache_helper.dart';

import '../../../../core/networking/firebase_constsnts.dart';
import '../../../../core/networking/firebase_result.dart';
import '../../../sign_up/data/models/user_model.dart';
import '../models/feedModel.dart';

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

  Future<FirebaseResult<List<UserModel>>> getAllUser() async {
    try {
      var response = await database
          .collection(FirebaseConstants.profile)
          .get()
          .then((value) =>
              value.docs.map((e) => UserModel.fromJson(e.data())).toList());

      return FirebaseResult.success(response);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(e);
    }
  }

  Future<FirebaseResult<String>> uploadImage(File file) async {
    try {
      var response =
          storageRef.child('tweet/${Uri.file(file.path).pathSegments.last}');

      await response.putFile(file);
      String imageUrl = await response.getDownloadURL();
      print('imageUrl = $imageUrl');
      return FirebaseResult.success(imageUrl);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(e);
    }
  }

  Future<FirebaseResult<String>> createTweet(FeedModel model) async {
    try {
      var response = await database
          .collection(FirebaseConstants.tweet)
          .add(model.toJson());

      return FirebaseResult.success(response.id);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.failure(e);
    }
  }
}
