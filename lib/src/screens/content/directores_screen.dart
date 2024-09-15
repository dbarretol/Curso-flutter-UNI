import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/screens/content/directores_insert_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/dimensions.dart';

class DirectoresScreen extends StatefulWidget {
  const DirectoresScreen({super.key});
  @override
  _DirectoresScreenState createState() => _DirectoresScreenState();
}

class _DirectoresScreenState extends State<DirectoresScreen> {
  List<dynamic> _directores = [];

  @override
  void initState() {
    super.initState();
    _fetchDirectores();
  }

  // Definir función _fetchDirectores
  Future<void> _fetchDirectores() async {
    final response =
        await http.get(Uri.parse('https://servicios.campus.pe/directores.php'));

    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _directores = data;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Directores'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Center(
          child: _directores.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _directores.length,
                  itemBuilder: (context, index) {
                    final director = _directores[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: Dimensions.tinyPadding,
                        horizontal: Dimensions.smallPadding,
                      ),
                      child: ListTile(
                          title: Text(director["iddirector"] ?? 'No name',
                              style: Theme.of(context).textTheme.titleLarge),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                director["nombres"] ?? 'No contact',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(director["peliculas"] ?? 'No cargo'),
                            ],
                          )),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DirectoresInsertScreen()));
                },        
        tooltip: 'Nuevo director',
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}