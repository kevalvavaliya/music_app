import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  //Default theme mode
  ThemeMode themeMode = ThemeMode.dark;
  ThemeProvider() {
    getThemeFromPreferences();
  }

  // toggle theme mode
  Future<bool> toggleThemeMode() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    return await storeThemeInPreferences(themeMode);
  }

  // set thememode in state
  void setThemeMode(ThemeMode thememode) {
    themeMode = thememode;
    notifyListeners();
  }

  // get current theme mode
  ThemeMode getthemeMode() {
    return themeMode;
  }

  // store theme pereferences in local
  Future<bool> storeThemeInPreferences(ThemeMode thememode) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = await prefs.setString('theme', themeMode.name);
      if (result) {
        setThemeMode(thememode);
      }
      return result;
    } catch (e) {
      log("Failed to store language preferences $e");
      return false;
    }
  }

  // fetch theme pereferences from local
  Future<void> getThemeFromPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? theme = prefs.getString('theme');
      if (theme != null && theme == ThemeMode.light.name) {
        setThemeMode(ThemeMode.light);
      } else {
        setThemeMode(ThemeMode.dark);
      }
    } catch (e) {
      log("Failed to get language preferences $e");
    }
  }
}
