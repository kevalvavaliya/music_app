import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/theme_manager.dart';
import 'package:music_app/comman/theme/theme_provider.dart';
import 'package:music_app/features/authentication/domain/user_model.dart';
import 'package:music_app/features/authentication/presentation/controller/authentication_provider.dart';
import 'package:music_app/features/authentication/presentation/controller/user_provider.dart';
import 'package:music_app/features/authentication/presentation/login_screen.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
import 'package:music_app/features/home/presentation/home_screen.dart';
import 'package:music_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, UserProvider>(
          //intially create user provider with null user
          create: (context) => UserProvider(null),
          update: (context, authProvider, previousUserProvider) {
            // update app user when firebase user changes
            return UserProvider(authProvider.firebaseAuthUser != null
                ? UserModel(
                    uid: authProvider.firebaseAuthUser!.uid,
                    email: authProvider.firebaseAuthUser!.email!)
                : null);
          },
          lazy: false,
        ),
        ChangeNotifierProvider<SongsProvider>(
          create:(context) =>  SongsProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          title: 'Music App',
          theme: ThemeManager.instance.lightThemeData,
          darkTheme: ThemeManager.instance.darkThemeData,
          themeMode: themeProvider.getthemeMode(),
          home: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (userProvider.getUserFromAppState != null) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            },
          ),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
          },
        ),
      ),
    );
  }
}
