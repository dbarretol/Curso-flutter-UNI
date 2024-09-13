import 'package:flutter/material.dart';
import 'package:myapp/src/screens/content/employees_screen.dart';
import 'package:myapp/src/screens/content/store_screen.dart';
import 'package:myapp/src/screens/content/suppliers_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: AppColors.secondary),
                child: Text('Menu'),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Proveedores'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuppliersScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('Empleados'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeesScreen()));
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('Tienda'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StoreScreen()));
                  //Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: const Center(
          child: Text(
            'Inicio',
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Proveedores'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Tienda'),
          ]
        ),
      ),
    );
  }
}
