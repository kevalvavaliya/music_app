import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/comman/util/enums.dart';

// This repository is for authenticating user using firebase authentication

class FirebaseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase auth sign up/create account with email and password
  Future<FirebaseAuthStatus> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return FirebaseAuthStatus.success;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          log('Email already in use');
          return FirebaseAuthStatus.emailAlreadyInUse;
        case 'invalid-email':
          log('Invalid email');
          return FirebaseAuthStatus.invalidEmail;
        case 'operation-not-allowed':
          log('Operation not allowed');
          return FirebaseAuthStatus.operationNotAllowed;
        case 'weak-password':
          log('Weak password');
          return FirebaseAuthStatus.weakPassword;
        default:
          return FirebaseAuthStatus.undefined;
      }
    } catch (e) {
      log('Error in signup $e');
      return FirebaseAuthStatus.undefined;
    }
  }

  // Firebase auth sign in with email and password
  Future<FirebaseAuthStatus> signInWithEmailandPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return FirebaseAuthStatus.success;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      switch (e.code) {
        case 'user-not-found':
          log('User not found');
          return FirebaseAuthStatus.userNotFound;
        case 'invalid-credential':
          log('Wrong password');
          return FirebaseAuthStatus.wrongPassword;
        case 'too-many-requests':
          log('Too many requests');
          return FirebaseAuthStatus.tooManyRequests;
        default:
          return FirebaseAuthStatus.undefined;
      }
    } catch (e) {
      log('Error in signin $e');
      return FirebaseAuthStatus.undefined;
    }
  }

  // Firebase auth sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Error in signout $e');
    }
  }

  // Firebase auth state changes
  Stream<User?> get firebaseUserAuthChanges => _auth.authStateChanges();
}
