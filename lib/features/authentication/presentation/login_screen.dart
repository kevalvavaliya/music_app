import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/custom_colors.dart';
import 'package:music_app/comman/util/constants.dart';
import 'package:music_app/comman/util/custom_snackbar.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/comman/widgets/custom_elevated_loading%20_button.dart';
import 'package:music_app/features/authentication/presentation/controller/authentication_provider.dart';
import 'package:music_app/features/authentication/presentation/widgets/custom_auth_textfield.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = '/login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // login button click handler
  void loginOrSignup(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      CustomSnackBar.showSnackbar(context, 'Please enter email and password');
      return;
    }
    if (password.length < 6) {
      CustomSnackBar.showSnackbar(
          context, 'Password should be atleast 6 characters');
      return;
    }
    final status = await context
        .read<AuthenticationProvider>()
        .loginOrSignup(email, password);
    if (status != FirebaseAuthStatus.success && context.mounted) {
      CustomSnackBar.showSnackbar(
          context, 'Error while login or signup - ${status.name}');
    }
  }

  // build method
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
                      child: loginDisplayHeadText('THE BEST',
                          color: CustomColors.TEXT_COLOR_WHITE))
                ]),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 12, top: 0, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginDisplayHeadText(
                  'MUSIC COLLECTION',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomAuthTextField(
                    textEditingController: emailController,
                    label: 'email',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                CustomAuthTextField(
                  textEditingController: passController,
                  label: 'password',
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomElevatedLoadingButton(
                    label: 'Login/Signup',
                    onPressed: () => loginOrSignup(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // component
  Widget loginDisplayHeadText(String text, {Color? color}) {
    return FittedBox(
      child: Text(
        text,
        style: GoogleFonts.tinos(
            fontSize: 40, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}
