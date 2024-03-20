import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/features/authentication/data/auth_repository.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuthRepository firebaseAuthRepository =
      FirebaseAuthRepository();

  // User returned by firebase authentication
  User? firebaseAuthUser;

  AuthenticationProvider() {
    // listen to firebase user state changes
    firebaseAuthRepository.firebaseUserAuthChanges.listen((firebaseUser) {
      firebaseAuthUser = firebaseUser;
      log("notified auth listeners");
      notifyListeners();
    });
  }

  // If user is new than create account else sign in
  Future<FirebaseAuthStatus> loginOrSignup(
      String email, String password) async {
    final status = await firebaseAuthRepository.signUpWithEmailandPassword(
        email, password);
    if (status == FirebaseAuthStatus.emailAlreadyInUse) {
      return await firebaseAuthRepository.signInWithEmailandPassword(
          email, password);
    }
    return status;
  }

  // Sign out user
  Future<void> signOut() async {
    await firebaseAuthRepository.signOut();
  }
}
