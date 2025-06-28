import 'dart:developer';

import 'package:aqarak/domain/entities/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserProfile> fetchUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      log('User Profile Doc => $doc');
      return UserProfile.fromJson(doc.data()!);
    }
    throw Exception('User profile not found');
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
