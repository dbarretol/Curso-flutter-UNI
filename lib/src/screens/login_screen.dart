import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/src/screens/profile_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  bool _isSwitched = false;

  Future<void> _guardarDato() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("datos", "Hola");
  }

  Future<void> loginUser(String usuario, String clave) async {
    final response = await http.post(
        Uri.parse('https://servicios.campus.pe/iniciarsesion.php'),
        body: {
          'usuario': usuario,
          'clave': clave,
        });
    late String mensaje;
    switch (response.body) {
      case '-1':
        mensaje = "El usuario no existe";
        break;
      case '-2':
        mensaje = "La constraseña es incorrecta";
        break;
      default:
        mensaje = "Bienvenido";
        if (_isSwitched == true) {
          _guardarDato();
        }
    }
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: usuarioController,
                      decoration: const InputDecoration(
                          labelText: 'Usuario', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      controller: claveController,
                      decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    const Text('Guardar sesión'),
                    Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                          });
                        }),
                    ElevatedButton(
                        onPressed: () {
                          String usuario = usuarioController.text;
                          String clave = claveController.text;
                          loginUser(usuario, clave);
                        },
                        child: const Text("Iniciar sesión"))
                  ],
                ))),
      ),
    );
  }
}
