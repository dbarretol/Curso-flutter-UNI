import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/dimensions.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  _SuppliersScreenState createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  List<dynamic> _suppliers = [];

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
  }

  // Definir función _fetchSuppliers
  Future<void> _fetchSuppliers() async {
    final response = await http
        .get(Uri.parse('https://servicios.campus.pe/proveedores.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _suppliers = data;
      });
    } else {
      throw Exception("Error al leer los datos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: _suppliers.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = _suppliers[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: Dimensions.tinyPadding,
                        horizontal: Dimensions.smallPadding,
                      ),
                      child: ListTile(
                        title: Text(supplier["nombreempresa"] ?? 'No name'),
                        subtitle:
                            Text(supplier["nombrecontacto"] ?? 'No contact'),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
