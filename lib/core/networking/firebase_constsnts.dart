import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstants {
  static const String profile = "profile";
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore database = FirebaseFirestore.instance;
CollectionReference users = database.collection(FirebaseConstants.profile);
