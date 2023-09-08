import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apnibook/pages/home_page.dart';
import 'package:apnibook/pages/test_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(background: const Color(0xFFF2F2F2)),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: Colors.green.shade100,
        animationDuration: const Duration(milliseconds: 2000),
        duration: 2500,
        splash: 'assets/images/cash_book.png',
        splashIconSize: 150,
        splashTransition: SplashTransition.decoratedBoxTransition,
        nextScreen: const Home_Page(),
      ),
    );
  }
}
