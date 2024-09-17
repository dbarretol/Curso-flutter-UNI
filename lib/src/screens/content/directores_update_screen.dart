import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/src/screens/content/directores_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/app_colors.dart';

class DirectoresUpdateScreen extends StatefulWidget {
  final String iddirector; //requiriendo parametro externo
  final String nombres;
  final String peliculas;

  const DirectoresUpdateScreen(
      {super.key,
      required this.iddirector,
      required this.nombres,
      required this.peliculas});

  @override
  _DirectoresUpdateScreenState createState() => _DirectoresUpdateScreenState();
}

class _DirectoresUpdateScreenState extends State<DirectoresUpdateScreen> {
  //Declaramos las variables
  late TextEditingController iddirectorController = TextEditingController();
  late TextEditingController nombresController = TextEditingController();
  late TextEditingController peliculasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Inicializamos las variables
    iddirectorController = TextEditingController(text: widget.iddirector);
    nombresController = TextEditingController(text: widget.nombres);
    peliculasController = TextEditingController(text: widget.peliculas);
  }

  Future<void> updateDirector(
      String iddirector, String nombres, String peliculas) async {
    await http.post(
        Uri.parse('https://servicios.campus.pe/directoresupdate.php'),
        body: {
          'iddirector': iddirector,
          'nombres': nombres,
          'peliculas': peliculas,
        });
    Fluttertoast.showToast(
        msg: "Se ha actualizado los datos del director de código $iddirector",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DirectoresScreen()));
  }

  Future<void> deleteDirector(String iddirector) async {
    final response = await http.post(
      Uri.parse('https://servicios.campus.pe/directoresdelete.php'),
      body: {'iddirector': iddirector},
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "El director ha sido eliminado exitosamente",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.secondary.withOpacity(0.5),
        textColor: Colors.black,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DirectoresScreen()));
    } else {
      Fluttertoast.showToast(
        msg: "Error al eliminar el director",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _confirmDelete(String iddirector) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Eliminación"),
          content:
              const Text("¿Estás seguro de que deseas eliminar este director?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                deleteDirector(iddirector); // Ejecutar la eliminación
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Actualizar Director'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  readOnly: true,
                  controller: iddirectorController,
                  decoration: const InputDecoration(
                    labelText: 'Código',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nombresController,
                  decoration: const InputDecoration(
                    labelText: 'Nombres',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: peliculasController,
                  decoration: const InputDecoration(
                    labelText: 'Películas',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String iddirector = iddirectorController.text;
                    String nombres = nombresController.text;
                    String peliculas = peliculasController.text;
                    updateDirector(iddirector, nombres, peliculas);
                  },
                  child: const Text("Actualizar"),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 45.0,
                  ),
                  color: AppColors.primary,
                  onPressed: () {
                    _confirmDelete(
                        widget.iddirector); // Confirmación de eliminación
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
