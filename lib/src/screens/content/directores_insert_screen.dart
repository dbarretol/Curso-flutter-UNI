import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';

class DirectoresInsertScreen extends StatelessWidget {
  const DirectoresInsertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Directores Insert',
          ),
        ),
      ),
    );
  }
}