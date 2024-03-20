// this repository is for storing and managing user in cloud firestore

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/comman/util/constants.dart';
import 'package:music_app/features/authentication/domain/user_model.dart';
import 'package:music_app/features/home/domain/song_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // store user in firestore
  Future<void> storeUserInFirestore(UserModel user) async {
    try {
      await _firestore
          .collection(Constants.USERS_COLLECTION)
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      log('Error in storing user in firestore $e');
      rethrow;
    }
  }

  // get user from firestore
  Future<UserModel?> getUserFromFirestore(String uid) async {
    try {
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

  // update user song favourite list into firestore
  Future<bool> updateUserSongFavouriteList(UserModel user) async {
    try {
      await _firestore
          .collection(Constants.USERS_COLLECTION)
          .doc(user.uid)
          .update({'favouriteSongs': user.favouriteSongs});
      return true;
    } catch (e) {
      log('Error in updating favourite songs list $e');
      return false;
    }
  }

  Future<SongModel?> fetchSongFromFirebstoreUsingId(String id) async {
    final QuerySnapshot results = await _firestore
        .collection(Constants.SONGS_COLLECTION)
        .where('musicId', isEqualTo: id)
        .get();
    if (results.size != 0) {
      return SongModel.fromMap(
          results.docs.first.data() as Map<String, dynamic>);
    }

    return null;
  }
  
}
