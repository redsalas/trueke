import 'package:shared_preferences/shared_preferences.dart';
export 'dart:io';

class AppSettings {

  static final AppSettings _instance = new AppSettings._internal();

  factory AppSettings() {
    return _instance;
  }

  AppSettings._internal();

  SharedPreferences _preferences;

  initPrefs() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  get token {
    return _preferences.getString('token') ?? '';
  }

  set token( String value ) {
    _preferences.setString('token', value);
  }

  get userId {
    return _preferences.getString('userId') ?? '';
  }

  set userId( String value ) {
    _preferences.setString('userId', value);
  }

  get userName {
    return _preferences.getString('userName') ?? '';
  }

  set userName( String value ) {
    _preferences.setString('userName', value);
  }

  get image {
    return _preferences.getString('image') ?? 'default.png';
  }

  set image( String value ) {
    _preferences.setString('image', value);
  }

  get truekoin {
    return _preferences.getString('truekoin') ?? '0';
  }

  set truekoin( String value ) {
    _preferences.setString('truekoin', value);
  }
}