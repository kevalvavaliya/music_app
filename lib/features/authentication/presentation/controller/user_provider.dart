import 'package:flutter/material.dart';
import 'package:music_app/features/authentication/data/user_repository.dart';
import 'package:music_app/features/authentication/domain/user_model.dart';
import 'package:music_app/features/home/domain/song_model.dart';

class UserProvider extends ChangeNotifier {
  // Own App user
  UserModel? appUser;
  bool isLoading = false;
  final UserRepository _userRepository = UserRepository();
  List<SongModel> userFavouriteSongsList = [];

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

  // get user from app state
  UserModel? get getUserFromAppState => appUser;

  // Add favourite song of user
  Future<bool> addSongToFavourite(SongModel song) async {
    if (appUser!.favouriteSongs.add(song.musicId)) {
      userFavouriteSongsList.add(song);
      setUserInAppState(appUser);
      return await _userRepository.updateUserSongFavouriteList(appUser!);
    }
    return false;
  }

  // remove favourite song of user
  Future<bool> removeSongFromFavourite(SongModel song) async {
    if (appUser!.favouriteSongs.remove(song.musicId)) {
      userFavouriteSongsList.remove(song);
      setUserInAppState(appUser);
      return await _userRepository.updateUserSongFavouriteList(appUser!);
    }
    return false;
  }

  // syncing favourite songs list
  Future<void> syncFavouriteSongs() async {
    if (appUser != null) {
      // fetching fresh user with fresh favourite songs
      setUserInAppState(
          await _userRepository.getUserFromFirestore(appUser!.uid));
      List<SongModel> tempList = [];
      for (String id in appUser!.favouriteSongs) {
        final SongModel? song =
            await _userRepository.fetchSongFromFirebstoreUsingId(id);
        if (song != null) {
          tempList.add(song);
        }
      }
      if (tempList.isNotEmpty) {
        setFavouriteSongsList(tempList);
      }
    }
  }

  // setting list in state
  void setFavouriteSongsList(List<SongModel> songs) {
    userFavouriteSongsList = songs;
    notifyListeners();
  }

  List<SongModel> getFavouriteSongsList() {
    return userFavouriteSongsList;
  }
}
