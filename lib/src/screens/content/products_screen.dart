import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;

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
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              product["imagenchica"] == null
                                  ? 'https://servicios.campus.pe/imagenes/nofoto.jpg'
                                  : 'https://servicios.campus.pe/${product["imagenchica"]}',
                              fit: BoxFit.cover,
                            ),
                            if (product["preciorebajado"] != '0')
                              Container(
                                color: Colors.yellow,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  ((1 - double.parse(product['preciorebajado']) / double.parse(product['precio'])) * 100)
                                      .toStringAsFixed(0) + '%',
                                ),
                              ),
                          ],
                        ),
                        Text(product["nombre"], textAlign: TextAlign.center),
                        Text(
                          's/ ${double.parse(product["preciorebajado"] == '0'
                                  ? product["precio"]
                                  : product["preciorebajado"])
                              .toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (product["preciorebajado"] != '0')
                          Text(
                            'S/ ${double.parse(product["precio"]).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.black38,
                              decoration: TextDecoration.lineThrough,
                            ),
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