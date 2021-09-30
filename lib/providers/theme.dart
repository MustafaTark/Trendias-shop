import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotfire with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: Color(0xFF302E2E),
    backgroundColor: Colors.black38,
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
    iconTheme: IconThemeData(color: Colors.white),
    focusColor: Colors.redAccent,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Colors.white38,
    accentColor: Colors.redAccent,
    iconTheme: IconThemeData(color: Colors.black),
    focusColor: Colors.redAccent,
  );
  ThemeData _themeData = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: Colors.redAccent,
    backgroundColor: Colors.white38,
    iconTheme: IconThemeData(color: Colors.black),
  );
  ThemeData getTheme() => _themeData;
  void setDarkMode() async {
    _themeData = darkTheme;
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    notifyListeners();
  }
}
