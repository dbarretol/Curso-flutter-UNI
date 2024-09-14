import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/dimensions.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://servicios.campus.pe/categorias.php'));

    final List<dynamic> data = json.decode(response.body);
    setState(() {
      data.sort((a, b) =>
          int.parse(a["idcategoria"]).compareTo(int.parse(b["idcategoria"])));
      _categories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Categorias'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: _categories.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: Dimensions.tinyPadding,
                        horizontal: Dimensions.smallPadding,
                      ),
                      child: Column(
                        // Added alignment for better layout
                        children: [
                          Image.network("https://servicios.campus.pe/" +
                              category["foto"]),
                          Text(
                            category["idcategoria"] ?? 'No category',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            category["nombre"] ?? 'No name',
                          ),
                          Text(
                            category["descripcion"] ?? 'No description',
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
