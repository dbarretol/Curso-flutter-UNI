import 'package:flutter/material.dart';
import 'package:myapp/src/screens/splash_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const SplashScreen()
    );
  }
}