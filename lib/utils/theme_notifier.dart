import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier{

  String _key = "theme_status";
  bool _isDarkTheme;
  ThemeNotifier(){
    getFromPref();
  }

  bool get isDarkTheme => _isDarkTheme;

  switchTheme(bool value){
    _isDarkTheme = value;
    saveToPref();
    notifyListeners();
  }

  saveToPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, _isDarkTheme);
  }

  getFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(_key) ?? false;
    notifyListeners();
  }
}