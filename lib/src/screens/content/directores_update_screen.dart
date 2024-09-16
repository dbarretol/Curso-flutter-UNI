import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/src/screens/content/directores_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;

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
        //timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DirectoresScreen()));
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
                      readOnly: true,
                      controller: iddirectorController,
                      decoration: const InputDecoration(
                          labelText: 'Código', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
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
                          String iddirector = iddirectorController.text;
                          String nombres = nombresController.text;
                          String peliculas = peliculasController.text;
                          updateDirector(iddirector, nombres, peliculas);
                        },
                        child: const Text("Actualizar"))
                  ],
                ))),
      ),
    );
  }
}
