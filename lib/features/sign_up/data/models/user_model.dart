import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? key;
  String? email;
  String? userId;
  String? displayName;
  String? userName;
  String? webSite;
  String? profilePic;
  String? bannerImage;
  String? contact;
  String? bio;
  String? location;
  String? dob;
  String? phone;
  String? createdAt;
  bool? isVerified;
  int? followers;
  int? following;
  String? fcmToken;
  List<String>? followersList;
  List<String>? followingList;

  UserModel(
      {this.email,
      this.userId,
      this.displayName,
      this.profilePic,
      this.bannerImage,
      this.key,
      this.contact,
      this.bio,
      this.dob,
      this.phone,
      this.location,
      this.createdAt,
      this.userName,
      this.followers,
      this.following,
      this.webSite,
      this.isVerified,
      this.fcmToken,
      this.followersList,
      this.followingList});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);

  String get getFollower {
    return '${followers ?? 0}';
  }

  String get getFollowing {
    return '${following ?? 0}';
  }
}
