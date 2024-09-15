import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';

class DirectoresInsertScreen extends StatefulWidget {
  const DirectoresInsertScreen({super.key});

  @override
  _DirectoresInsertScreenState createState() => _DirectoresInsertScreenState();
}

class _DirectoresInsertScreenState extends State<DirectoresInsertScreen> {
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController peliculasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nombresController,
                      decoration: const InputDecoration(
                          labelText: 'Nombres', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: peliculasController,
                      decoration: const InputDecoration(
                          labelText: 'Peliculas', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          String nombres = nombresController.text;
                          String peliculas = peliculasController.text;
                        },
                        child: const Text("Guardar"))
                  ],
                ))),
      ),
    );
  }
}
