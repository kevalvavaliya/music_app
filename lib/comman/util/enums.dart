// enum for firebase auth state
enum FirebaseAuthStatus {
  invalidEmail,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  weakPassword,
  tooManyRequests,
  operationNotAllowed,
  undefined,
  success, 
}

// enum for song state
enum SongState{playing,paused,resume,stopped}