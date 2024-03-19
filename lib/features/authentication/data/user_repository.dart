// this repository is for storing and managing user in cloud firestore

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/comman/util/constants.dart';
import 'package:music_app/features/authentication/domain/user_model.dart';

class UserRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeUserInFirestore(UserModel user) async {
    try {
      // store user in firestore
      await _firestore
          .collection(Constants.USERS_COLLECTION)
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      log('Error in storing user in firestore $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserFromFirestore(String uid) async {
    try {
      // get user from firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection(Constants.USERS_COLLECTION)
          .doc(uid)
          .get();
      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      log('Error in getting user from firestore $e');
      return null;
    }
  }
}
