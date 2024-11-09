import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode appThemeMode = ThemeMode.light;
  String localCode = 'en';

  bool get isDark => appThemeMode == ThemeMode.dark;

  void changeThemeMode(ThemeMode themeMode)
  {
          appThemeMode = themeMode;
          notifyListeners();
  }

  void changeAppLocal(String local) {
    localCode = local;
    notifyListeners();
  }
}