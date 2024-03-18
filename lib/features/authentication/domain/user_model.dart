class AppUser {
  final String uid;
  final String email;

  AppUser({required this.uid, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
    );
  }
}
