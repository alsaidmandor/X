// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      userId: json['userId'] as String?,
      displayName: json['displayName'] as String?,
      profilePic: json['profilePic'] as String?,
      bannerImage: json['bannerImage'] as String?,
      key: json['key'] as String?,
      contact: json['contact'] as String?,
      bio: json['bio'] as String?,
      dob: json['dob'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      createdAt: json['createdAt'] as String?,
      userName: json['userName'] as String?,
      followers: json['followers'] as int?,
      following: json['following'] as int?,
      webSite: json['webSite'] as String?,
      isVerified: json['isVerified'] as bool?,
      fcmToken: json['fcmToken'] as String?,
      followersList: (json['followersList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followingList: (json['followingList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'key': instance.key,
      'email': instance.email,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'userName': instance.userName,
      'webSite': instance.webSite,
      'profilePic': instance.profilePic,
      'bannerImage': instance.bannerImage,
      'contact': instance.contact,
      'bio': instance.bio,
      'location': instance.location,
      'dob': instance.dob,
      'phone': instance.phone,
      'createdAt': instance.createdAt,
      'isVerified': instance.isVerified,
      'followers': instance.followers,
      'following': instance.following,
      'fcmToken': instance.fcmToken,
      'followersList': instance.followersList,
      'followingList': instance.followingList,
    };
