import 'package:flutter/material.dart';
import 'package:trueke/screens/login_screen.dart';
import 'package:trueke/screens/signup_screen.dart';

class Routes {
  static Route<dynamic> initialize(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/sign_up':
        return MaterialPageRoute(
            builder: (c) => SignUpScreen()
        );
      case '/login':
        return MaterialPageRoute(
            builder: (c) => LoginScreen()
        );
      default:
        return null;
    }
  }
}