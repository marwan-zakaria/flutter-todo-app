import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.light;
  String currentLang ='en';
  SettingsProvider() {
    _loadPreferences();
  }

   void changeAppLanguage(String newLanguage)async {

    if(currentLang == newLanguage)
      return;

    currentLang = newLanguage;
    notifyListeners(); // Send notifications to all app that a change has occurred.

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
  }



  void changeThemeMode(ThemeMode newTheme) async{

    if(currentTheme == newTheme)
      return;

    currentTheme = newTheme;
    notifyListeners(); // Send notifications to all app that a change has occurred.

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', newTheme == ThemeMode.light ? 'light' : 'dark');
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    currentLang = prefs.getString('language') ?? 'en';

    final themeMode = prefs.getString('themeMode') ?? 'light';
    currentTheme = themeMode == 'light' ? ThemeMode.light : ThemeMode.dark;

    notifyListeners(); // Notify listeners after loading preferences
  }



}