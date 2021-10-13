import 'package:flutter/material.dart';
import 'package:trueke/screens/create_post_screen.dart';
import 'package:trueke/screens/home_screen.dart';
import 'package:trueke/screens/item_description_screen.dart';
import 'package:trueke/screens/login_screen.dart';
import 'package:trueke/screens/onboarding_screen.dart';
import 'package:trueke/screens/signup_screen.dart';
import 'package:trueke/screens/post_category_screen.dart';
import 'package:trueke/screens/trueke_screen.dart';
import 'package:trueke/screens/user_posts_screen.dart';
import 'package:trueke/splash_screen.dart';

class Routes {
  static Route<dynamic> initialize(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/splash_screen':
        return MaterialPageRoute(
            builder: (c) => SplashScreen()
        );
      case '/sign_up':
        return MaterialPageRoute(
            builder: (c) => SignUpScreen()
        );
      case '/login':
        return MaterialPageRoute(
            builder: (c) => LoginScreen()
        );
      case '/onboarding':
        return MaterialPageRoute(
            builder: (c) => OnboardingScreen()
        );
      case '/home':
        return MaterialPageRoute(
          builder: (c) => HomeScreen()
        );
      case '/item_description':
        return MaterialPageRoute(
            builder: (c) => ItemDescriptionScreen(json: args)
        );
      case '/post_category':
        return MaterialPageRoute(
            builder: (c) => PostCategoryScreen(category: args)
        );
      case '/user_posts':
        return MaterialPageRoute(
            builder: (c) => UserPostScreen()
        );
      case '/create_post':
        return MaterialPageRoute(
            builder: (c) => CreatePostScreen()
        );
      case '/trueke':
        return MaterialPageRoute(
            builder: (c) => TruekeScreen(product: args)
        );
      case '/trueke':
        return MaterialPageRoute(
            builder: (c) => TruekeScreen(product: args)
        );
      default:
        return null;
    }
  }
}