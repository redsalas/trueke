import 'package:flutter/material.dart';
import 'package:trueke/app_settings.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final settings = new AppSettings();

final String serverHost = "https://sagarsoftware.com/api";
final String serverLogin = "$serverHost/login";
final String serverRegister = "$serverHost/register";
final String serverPosts = "$serverHost/get/posts";
final String serverPost = "$serverPost/get/post";

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

String day(DateTime date, {String separator = '/'}){
  return '${date.day}$separator${date.month}$separator${date.year}';
}

String dayInverse(DateTime date, {String separator = '-'}){
  return '${date.year}$separator${date.month}$separator${date.day}';
}

String dateSql(DateTime date){
  return '${date.year}-${date.month}-${date.day}';
}

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);