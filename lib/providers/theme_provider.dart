import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeModeKey = 'theme_mode';

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setLightMode() {
    _themeMode = ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _saveThemeMode();
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setDarkMode();
    } else {
      setLightMode();
    }
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeValue = prefs.getInt(_themeModeKey);

    if (themeModeValue != null) {
      _themeMode = ThemeMode.values[themeModeValue];
      notifyListeners();
    }
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, _themeMode.index);
  }
}
