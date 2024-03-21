// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:music_app/features/authentication/data/auth_repository.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// void main() {
//   MockFirebaseAuth mockFirebaseAuth;
//   FirebaseAuthRepository authRepository;

//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     authRepository = FirebaseAuthRepository(auth: mockFirebaseAuth);
//   });

//   group('signInWithEmailAndPassword', () {
//     test('should return user when sign in is successful', () async {
//       // Arrange
//       final email = 'test@example.com';
//       final password = 'password';
//       final userCredential = MockUserCredential();
//       MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
//       when(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       )).thenAnswer((_) => Future.value(userCredential));

//       // Act
//       FirebaseAuthRepository authRepository =
//           FirebaseAuthRepository(auth: mockFirebaseAuth);
//       final result = await authRepository.signInWithEmailandPassword(
//         email,
//         password,
//       );

//       // Assert
//       expect(result, userCredential.user);
//     });
//   });

//   //   test('should throw an exception when sign in fails', () async {
//   //     // Arrange
//   //     final email = 'test@example.com';
//   //     final password = 'password';
//   //     final exception = FirebaseAuthException(code: 'error');
//   //     when(mockFirebaseAuth.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     )).thenThrow(exception);

//   //     // Act
//   //     final call = authRepository.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );

//   //     // Assert
//   //     expect(call, throwsA(exception));
//   //   });
//   // });

//   // Add more test cases for other methods in FirebaseAuthRepository
// }

// class MockUserCredential extends Mock implements UserCredential {}
