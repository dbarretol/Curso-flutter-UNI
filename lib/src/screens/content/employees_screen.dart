import 'package:flutter/material.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/app_colors.dart';
import 'package:myapp/utils/dimensions.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                  scrollDirection: Axis.horizontal,
                  itemCount: _employees.length,
                  itemBuilder: (context, index) {
                    final employee = _employees[index];
                    return Stack(
                      children: [
                        Image.network(
                          "https://servicios.campus.pe/fotos/" +
                              employee["foto"],
                          width: screenWidth,
                          height: screenHeight,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                  AppColors.onSecondary.withOpacity(1),
                                  Colors.transparent
                                ],
                                    stops: const [
                                  0.0,
                                  0.5
                                ])),
                          ),
                        ),
                        Positioned(
                          bottom: Dimensions.mediumPadding,
                          right: Dimensions.mediumPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (employee["nombres"] +
                                        ' ' +
                                        employee["apellidos"]) ??
                                    'No name',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: AppColors.onPrimary),
                              ),
                              Text(
                                employee["cargo"] ?? 'No position',
                                style: const TextStyle(
                                  color: AppColors.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
