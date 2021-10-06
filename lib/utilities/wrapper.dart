import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trueke/screens/home_screen.dart';
import 'package:trueke/screens/login_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user != null) {
      return HomeScreen(user: user);
    } else {
      return LoginScreen();
    }
  }
}
