import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:trueke/providers/app.dart';
import 'package:trueke/providers/user_provider.dart';
import 'package:trueke/routes.dart';

import 'app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = new AppSettings();
  await settings.initPrefs();
  HttpOverrides.global = new MyHttpOverrides();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => App())
        ],
        child: UserProvider(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Trueke",
              onGenerateRoute: Routes.initialize,
              initialRoute: '/splash_screen',
              builder: EasyLoading.init(),
            )
        )
    ),
  );

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        final isValidHost = host == "sagarsoftware.com";
        return isValidHost;
      };
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text("Ha ocurrido un error :(")
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
