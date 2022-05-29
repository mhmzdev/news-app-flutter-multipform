import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/cubits/top_headlines/cubit.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/screens/dashboard/dashboard.dart';
import 'package:news_app/screens/splash/splash.dart';
import 'package:news_app/screens/top_stories/top_stories.dart';
import 'package:provider/provider.dart';
import 'configs/core_theme.dart' as theme;

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<News>(NewsAdapter());

  await Hive.openBox('app');
  await Hive.openBox('newsBox');

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

    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => TopHeadlinesCubit()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: theme.themeLight,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/top-stories': (context) => const TopStoriesScreen(),
        },
      ),
    );
  }
}
