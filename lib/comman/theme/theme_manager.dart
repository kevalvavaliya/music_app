import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/custom_colors.dart';

class ThemeManager extends ChangeNotifier {
  static ThemeManager instance = ThemeManager._();

  ThemeManager._();

  // Light theme object
  ThemeData get lightThemeData => ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      
      colorSchemeSeed: CustomColors.PRIMARY_COLOR,
      scaffoldBackgroundColor: CustomColors.SCAFFOLD_BACKGROUND_LIGHT,

      // light elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonstyle),

      // light textfield theme
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: CustomColors.TEXTFIELD_OUTLINE_COLOR),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: CustomColors.TEXTFIELD_OUTLINE_COLOR),
          borderRadius: BorderRadius.circular(50),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      ),
      iconTheme: const IconThemeData(color: CustomColors.PRIMARY_COLOR));

  // Dark theme object
  ThemeData get darkThemeData => ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: CustomColors.PRIMARY_COLOR,
      scaffoldBackgroundColor: CustomColors.SCAFFOLD_BACKGROUND_DARK,

      // dark elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonstyle),

      // dark textfield theme
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: CustomColors.TEXTFIELD_OUTLINE_COLOR),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: CustomColors.TEXTFIELD_OUTLINE_COLOR),
          borderRadius: BorderRadius.circular(50),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      ),

      iconTheme: const IconThemeData(color: CustomColors.PRIMARY_COLOR),

      
      );

  //comm
  //
  //an styling for elevated button
  ButtonStyle elevatedButtonstyle = ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: CustomColors.PRIMARY_COLOR,
      foregroundColor: Colors.white);
}
