import 'package:flutter/material.dart';
import 'package:myapp/src/screens/content/directores_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;

class DirectoresInsertScreen extends StatefulWidget {
  const DirectoresInsertScreen({super.key});

  @override
  _DirectoresInsertScreenState createState() => _DirectoresInsertScreenState();
}

class _DirectoresInsertScreenState extends State<DirectoresInsertScreen> {
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController peliculasController = TextEditingController();

//Creacion de metodo
  Future<void> insertDirector(String nombres, String peliculas) async {
    await http.post(
        Uri.parse('https://servicios.campus.pe/directoresinsert.php'),
        body: {
          'nombres': nombres,
          'peliculas': peliculas,
        });
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DirectoresScreen()));
  }

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
                          insertDirector(nombres, peliculas);
                        },
                        child: const Text("Guardar"))
                  ],
                ))),
      ),
    );
  }
}
