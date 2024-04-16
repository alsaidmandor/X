import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseConstants {
  static const String profile = "profile";
  static const String tweet = "tweet";
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore database = FirebaseFirestore.instance;
CollectionReference users = database.collection(FirebaseConstants.profile);
Reference storageRef = FirebaseStorage.instance.ref();
