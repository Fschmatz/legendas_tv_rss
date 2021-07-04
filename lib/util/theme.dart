import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    accentColor: Color(0xFF3AA680),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    cardTheme: CardTheme(
      color: Color(0xFFF1F1F1),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9F9),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Colors.deepPurple),
      selectedLabelStyle: TextStyle(color: Colors.deepPurple),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFFE5E5E5),
    ),
    bottomAppBarColor: Color(0xFFE6E6E6),
    bottomSheetTheme:
    BottomSheetThemeData(modalBackgroundColor: Color(0xFFF5F5F5)));

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF202022),
    accentColor: Color(0xFF67CBA8),// rosa 0xFFD4669D turq- 0xFF67CBA8
    scaffoldBackgroundColor: Color(0xFF202022),
    cardTheme: CardTheme(
      color: Color(0xFF29292B),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF29292B),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFFA590D5)),
      selectedLabelStyle: TextStyle(color: Color(0xFFA590D5)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF151517),
    ),
    bottomAppBarColor: Color(0xFF151517),
    bottomSheetTheme:
    BottomSheetThemeData(modalBackgroundColor: Color(0xFF202022)));

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
      prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
