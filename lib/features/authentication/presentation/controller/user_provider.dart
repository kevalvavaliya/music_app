import 'package:flutter/material.dart';
import 'package:music_app/features/authentication/data/user_repository.dart';
import 'package:music_app/features/authentication/domain/user_model.dart';

class UserProvider extends ChangeNotifier {
  // Own App user
  UserModel? appUser;
  bool isLoading = false;
  final UserRepository _userRepository = UserRepository();

  UserProvider(UserModel? appUser) {
    // if appuser is null means user is not logged in
    if (appUser == null) {
      setUserInAppState(null);
    } else {
      isLoading = true;
      notifyListeners();
      // if user is logged in then get user from firestore. if user is not in firestore then store user in firestore
      _userRepository.getUserFromFirestore(appUser.uid).then((user) {
        if (user == null) {
          _userRepository.storeUserInFirestore(appUser).then((_) {
            isLoading = false;
            setUserInAppState(appUser);
          }).onError((error, stackTrace) {
            isLoading = false;
            notifyListeners();
          });
        } else {
          isLoading = false;
          setUserInAppState(user);
        }
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
      });
    }
  }

  // setting user in app state
  void setUserInAppState(UserModel? user) {
    appUser = user;
    notifyListeners();
  }

  // // store user
  // void storeUser(UserModel user) {
  //   _userRepository.storeUserInFirestore(user);
  // }

  // get user from app state
  UserModel? get getUserFromAppState => appUser;
}
