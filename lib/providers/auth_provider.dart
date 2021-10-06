import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading;
  bool _isLogin;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthProvider() {
    _isLoading = false;
    _isLogin = false;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }


  Future register(String email, String password) async {
    isLoading = true;
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      isLoading = false;
      return user;
    } on SocketException {
      print("No connection");
      isLoading = false;
    } catch(error) {
      print(error);
      isLoading = false;
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  Future login(String email, String password) async {
    isLoading = true;
    try {
      UserCredential authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User user = authResult.user;

      isLoading = false;
      return user;
    } on SocketException {
      print("No connection");
      isLoading = false;
    } catch (err) {
      print(err);
      isLoading = false;
    }
    notifyListeners();
  }

  Stream<User> get user => firebaseAuth.authStateChanges().map((event) => event);
}