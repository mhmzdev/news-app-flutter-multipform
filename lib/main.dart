import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/dashboard/dashboard.dart';
import 'package:news_app/screens/splash/splash.dart';
import 'configs/core_theme.dart' as theme;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
