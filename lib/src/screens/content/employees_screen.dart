import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/app_colors.dart';
import 'package:myapp/utils/dimensions.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeesScreen> {
  List<dynamic> _employees = [];

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    final response =
        await http.get(Uri.parse('https://servicios.campus.pe/empleados.php'));

    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _employees = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Empleados'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: _employees.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _employees.length,
                  itemBuilder: (context, index) {
                    final employee = _employees[index];
                    return Stack(children: [
                      Positioned.fill(
                        child: Image.network(
                            "https://servicios.campus.pe/fotos/" + employee["foto"],
                            fit: BoxFit.cover),
                      ),
                      Positioned.fill(
                          child: Container(
                        color: AppColors.onSurface.withOpacity(0.6),
                      )),
                      Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.mediumPadding),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 60,
                                  child: Text(
                                    employee["idempleado"] ?? 'No id',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(color: AppColors.onPrimary),
                                  )),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // Added alignment for better layout
                                  children: [
                                    Text(
                                      employee["nombres"] ?? 'No name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                              color: AppColors.onPrimary),
                                    ),
                                    Text(
                                        employee["apellidos"] ??
                                            'No description',
                                        style: const TextStyle(
                                            color: AppColors.onPrimary)),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ]);
                  },
                ),
        ),
      ),
    );
  }
}
