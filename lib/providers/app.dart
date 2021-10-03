import 'package:flutter/material.dart';


class App with ChangeNotifier {
  ThemeData _theme = lightTheme;
  ThemeData get theme => _theme;

  setTheme(bool dark){
    _theme = dark ? darkTheme : lightTheme;
    notifyListeners();
  }
}

final Color primary = Colors.blue;
final Color black = Colors.black;
final Color secundaryColor = Colors.blue;
final Color blugrey = Colors.blueGrey[900];
final Color white = Colors.white;
final Color backgroundBlack = Color(0xFF121212);


ThemeData darkTheme = ThemeData(
  fontFamily: 'ProductSans',
  appBarTheme: AppBarTheme(
    color: backgroundBlack,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
  ),
  scaffoldBackgroundColor: backgroundBlack,
  bottomAppBarColor: Color(0xFF09090C),
  brightness: Brightness.dark,
  primaryColor: primary,
  backgroundColor: backgroundBlack,
  accentColor: secundaryColor,
  dividerColor: Colors.white54,
  accentColorBrightness: ThemeData.estimateBrightnessForColor(secundaryColor),
  primaryColorBrightness: ThemeData.estimateBrightnessForColor(backgroundBlack),
  primarySwatch: Colors.grey,
  accentIconTheme: IconThemeData(color: Colors.blueGrey[900]),

);

ThemeData lightTheme = ThemeData(
  fontFamily: 'ProductSans',
  appBarTheme: AppBarTheme(
      color: white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.blueGrey[900]),
      actionsIconTheme: IconThemeData(color: Colors.blueGrey[900]),
      elevation: 0
  ),
  scaffoldBackgroundColor: white,
  bottomAppBarColor: Colors.white,
  backgroundColor: white,
  accentColor: secundaryColor,
  dividerColor: Colors.white54,
  accentColorBrightness: ThemeData.estimateBrightnessForColor(secundaryColor),
  primaryColorBrightness: ThemeData.estimateBrightnessForColor(white),
  brightness: Brightness.light,
  primaryColor: primary,
  primarySwatch: Colors.grey,
  accentIconTheme: IconThemeData(color: Colors.white),
);