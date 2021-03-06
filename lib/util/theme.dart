import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: Color(0xFFfefcf4),
    colorScheme: ColorScheme.light(
      primary: Color(0xff76990b),
      secondary: Color(0xFF5a6146),
      surface: Color(0xFFe3e4d4),
      background: Color(0xFFfefcf4),
    ),
    scaffoldBackgroundColor: Color(0xFFfefcf4),
    cardTheme: CardTheme(
      color: Color(0xFFe3e4d4),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFFfefcf4),
        color: Color(0xFFfefcf4),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000))),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9F9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFD3D4C4),
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: Color(0xff76990b),
    ),
    bottomAppBarColor: Color(0xFFE6E6E6),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFD3D4C4),
        indicatorColor: Color(0xff76990b),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
        BottomSheetThemeData(modalBackgroundColor: Color(0xFFF5F5F5)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: Color(0xFF202122),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFadd53a),
      secondary: Color(0xFFadd53a),
    ),
    scaffoldBackgroundColor: Color(0xFF202122),
    cardTheme: CardTheme(
      color: Color(0xFF303233),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFF202122),
        color: Color(0xFF202122),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF))),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF303132),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      actionTextColor: Color(0xFFA6C442),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF28292A),
    ),
    bottomAppBarColor: Color(0xFF28292A),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF28292A),
        indicatorColor: const Color(0xff677931),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFEBEBEA),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEBEBEA), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
        BottomSheetThemeData(modalBackgroundColor: Color(0xFF202122)));
