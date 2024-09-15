import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:myapp/src/screens/content/product_detail_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;

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
      home: const Scaffold(
        body: Center(
          child: Text(
            'Detalle de productos',
          ),
        ),
      ),
    );
  }
}