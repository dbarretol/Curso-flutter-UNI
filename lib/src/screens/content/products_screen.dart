import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Productos',
          ),
        ),
      ),
    );
  }
}