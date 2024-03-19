import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/custom_colors.dart';
import 'package:music_app/comman/util/constants.dart';
import 'package:music_app/comman/util/custom_snackbar.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/features/authentication/presentation/controller/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = '/login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // login button click handler
  void loginOrSignup(BuildContext context) async {
    final email = emailController.text;
    final password = passController.text;
    if (email.isEmpty || password.isEmpty) {
      CustomSnackBar.showSnackBar(context, 'Please enter email and password');
      return;
    }
    if (password.length < 6) {
      CustomSnackBar.showSnackBar(
          context, 'Password should be atleast 6 characters');
      return;
    }
    final status = await context
        .read<AuthenticationProvider>()
        .loginOrSignup(email, password);
    if (status != FirebaseAuthStatus.success && context.mounted) {
      CustomSnackBar.showSnackBar(
          context, 'Error while login or signup - ${status.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Constants.SPLASH_IMAGE,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 16,
                    child: FittedBox(
                      child: Text(
                        'THE BEST',
                        style: GoogleFonts.tinos(
                            fontSize: 40,
                            color: CustomColors.TEXT_COLOR_DARK,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 12, top: 0, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    'MUSIC COLLECTION',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.tinos(
                        fontSize: 40,
                        // color: CustomColors.TEXT_COLOR_DARK,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: passController,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    )),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      loginOrSignup(context);
                    },
                    child: Text('Login/Signup')),
                // ElevatedButton(
                //     onPressed: () {
                //       context.read<ThemeProvider>().toggleThemeMode();
                //     },
                //     child: Text('toggle'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
