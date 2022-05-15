import 'package:flutter/material.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
      body: Center(
        child: Text(
          'News App',
          style: AppText.h1b!.copyWith(
            fontSize: AppDimensions.normalize(40),
          ),
        ),
      ),
    );
  }
}
