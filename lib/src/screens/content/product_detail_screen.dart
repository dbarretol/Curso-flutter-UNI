import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:myapp/src/screens/content/product_detail_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class ProductDetailScreen extends StatefulWidget {
  final String productId; //requiriendo parametro externo
  const ProductDetailScreen({super.key, required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://servicios.campus.pe/productos.php?idproducto=${widget.productId}'));

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
          title: const Text('Detalle del producto'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    Text('Nombre: ${_products[0]['nombre']}'),
                    const Text('Descripción: '),
                    HtmlWidget(
                      _products[0]['descripcion']
                      )                    
                  ],
                ),
              ),
      ),
    );
  }
}
