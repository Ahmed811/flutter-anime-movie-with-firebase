import 'package:flutter/material.dart';

class CustomTheme extends ChangeNotifier {
  bool isDarkTheme = true;
  ThemeMode currentTheme() {
    if (isDarkTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      //  iconTheme: IconThemeData(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              primary: Colors.blueAccent,
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white))),
      accentColor: Colors.white,
      cardColor: Color(0xff1a191d),
      dividerColor: Colors.grey[600],
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: TextStyle(fontWeight: FontWeight.bold))),
      brightness: Brightness.dark);
  ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xffeeeeee),
      appBarTheme:
          AppBarTheme(backgroundColor: Color(0xffeeeeee), elevation: 0),
      //  iconTheme: IconThemeData(color: Colors.white),
      primaryColor: Color(0xffeeeeee),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              primary: Colors.blueAccent,
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white))),
      accentColor: Colors.black,

      // dividerColor: Colors.grey[600],
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: TextStyle(fontWeight: FontWeight.bold))),
      brightness: Brightness.light);
}
