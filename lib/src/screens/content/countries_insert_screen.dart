import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/utils/app_colors.dart';
import 'countries_screen.dart'; // Para regresar a la pantalla de países

class CountriesInsertScreen extends StatefulWidget {
  const CountriesInsertScreen({super.key});

  @override
  _CountriesInsertScreenState createState() => _CountriesInsertScreenState();
}

class _CountriesInsertScreenState extends State<CountriesInsertScreen> {
  // Controladores para los campos de texto
  final TextEditingController codPaisController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController poblacionController = TextEditingController();
  final TextEditingController continenteController = TextEditingController();

  // Método para insertar un país usando el servicio web
  Future<void> insertCountry(
    String codPais,
    String pais,
    String capital,
    String area,
    String poblacion,
    String continente,
  ) async {
    final response = await http.post(
      Uri.parse('https://servicios.campus.pe/paisesinsert.php'),
      body: {
        'codpais': codPais,
        'pais': pais,
        'capital': capital,
        'area': area,
        'poblacion': poblacion,
        'continente': continente,
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Se ha registrado un nuevo país",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors.secondary,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Regresar a la pantalla de países después de la inserción
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CountriesScreen()),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error al registrar el país",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar País'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campos de texto para capturar la información
                TextField(
                  controller: codPaisController,
                  decoration: const InputDecoration(
                    labelText: 'Código del País',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: paisController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del País',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: capitalController,
                  decoration: const InputDecoration(
                    labelText: 'Capital',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: areaController,
                  decoration: const InputDecoration(
                    labelText: 'Área (km²)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: poblacionController,
                  decoration: const InputDecoration(
                    labelText: 'Población',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: continenteController,
                  decoration: const InputDecoration(
                    labelText: 'Continente',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón para guardar
                ElevatedButton(
                  onPressed: () {
                    // Obtener los valores de los campos
                    String codPais = codPaisController.text;
                    String pais = paisController.text;
                    String capital = capitalController.text;
                    String area = areaController.text;
                    String poblacion = poblacionController.text;
                    String continente = continenteController.text;

                    // Llamar al método insertCountry
                    insertCountry(
                        codPais, pais, capital, area, poblacion, continente);
                  },
                  child: const Text("Guardar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
