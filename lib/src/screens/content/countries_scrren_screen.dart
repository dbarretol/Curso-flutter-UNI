import 'package:flutter/material.dart';

class CountriesInsertScreen extends StatelessWidget {
  const CountriesInsertScreen({super.key});

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
      body: const Center(
        child: Text('Formulario para insertar un nuevo país'),
      ),
    );
  }
}
