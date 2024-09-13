import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Tienda',
          ),
        ),
      ),
    );
  }
}