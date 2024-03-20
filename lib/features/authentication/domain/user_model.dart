
class UserModel {
  final String uid;
  final String email;
  final Set<String> favouriteSongs;

  UserModel(
      {required this.uid, required this.email, this.favouriteSongs = const {}});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'favouriteSongs': favouriteSongs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        favouriteSongs: Set<String>.from(map['favouriteSongs']));
  }

  @override
  String toString() =>
      'UserModel(uid: $uid, email: $email , favouritesongs : ${favouriteSongs.toList()})';
}
