import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/content/countries_insert_screen.dart';
import 'package:myapp/utils/app_colors.dart';
//import 'package:your_project/countries_insert_screen.dart'; // Añade el archivo de la nueva pantalla de inserción

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<dynamic> _countries = [];

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  // Función para obtener los países del servicio web
  Future<void> _fetchCountries() async {
    final response = await http.get(Uri.parse('https://servicios.campus.pe/paises.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _countries = data;
      });
    } else {
      // Manejar el error aquí si la solicitud falla
      throw Exception('Failed to load countries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paises'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: _countries.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _countries.length,
                itemBuilder: (context, index) {
                  final country = _countries[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: Card(
                      color: AppColors.terciaryVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${country["idpais"]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Código: ${country["codpais"]}'),
                            Text('País: ${country["pais"]}'),
                            Text('Capital: ${country["capital"]}'),
                            Text('Área: ${country["area"]} km²'),
                            Text('Población: ${country["poblacion"]}'),
                            Text('Continente: ${country["continente"]}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CountriesInsertScreen()),
          );
        },
        tooltip: 'Nuevo país',
        child: const Icon(Icons.add),
      ),
    );
  }
}
