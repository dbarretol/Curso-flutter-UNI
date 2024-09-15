import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/dimensions.dart';

class ProductsScreen extends StatefulWidget {
  final String categoryId; //requiriendo parametro externo
  const ProductsScreen({super.key, required this.categoryId});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://servicios.campus.pe/productos.php?idcategoria=${widget.categoryId}'));

    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _products = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _products.isEmpty
            ? const CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //cantidad de columnas
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4 / 6,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          product["imagenchica"] == null
                              ? 'https://servicios.campus.pe/imagenes/nofoto.jpg'
                              : 'https://servicios.campus.pe/${product["imagenchica"]}',
                          fit: BoxFit.cover,
                        ),
                        Text(product["nombre"], textAlign: TextAlign.center),
                        Text(
                          's/ ${double.parse(product["precio"]).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
