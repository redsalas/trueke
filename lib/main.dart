import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trueke/providers/app.dart';
import 'package:trueke/screens/login_screen.dart';

Future<void> main() async {
  runApp(MyApp());
  /*WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => App()),
      ],
      child: ,
    )
  );*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trueke',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}