import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  bool darkMode = false;

  Color daytimeColor = Colors.orange;
  final Color nightColor = Colors.indigo;
  final Color dangerColor = Colors.redAccent;
  final Color greyColor = Colors.grey[600] ?? Colors.grey;

  void loadDarkModePrefs() async {
    final prefs = SharedPreferencesAsync();
    bool? mode = await prefs.getBool("darkMode");
    if (mode != null){
      setDarkMode(mode);
    }
    
    }

  void setDarkMode(bool mode) async {
    darkMode = mode;
    notifyListeners();
    final prefs = SharedPreferencesAsync();
    await prefs.setBool("darkMode", mode);
  }

  void setDaytimeColor(Color color) {
    daytimeColor = color;
    notifyListeners();
  }
}