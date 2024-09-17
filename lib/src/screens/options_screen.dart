import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/components/heading_image.dart';
import 'package:myapp/src/screens/content/countries_screen.dart';
import 'package:myapp/src/screens/content/orders_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/dimensions.dart'; // Asegúrate de tener esta ruta correcta

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              // Encabezado con imagen
              const HeadingImage(
                  imagePath: 'assets/images/foto_pedidos.jpg', title: "Opciones"),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.tinyPadding),
                child: Text(
                  'Elige una opción para continuar.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Ajusta el estilo del texto según sea necesario
                ),
              ),
              // Espacio flexible para centrar los botones verticalmente
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón "pedidos"
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.smallPadding,
                        horizontal: Dimensions.xLargePadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrdersScreen()),
                            );
                          },
                          child: const Text('Pedidos'),
                        ),
                      ),
                    ),
                    // Espacio entre los botones
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.largePadding,
                        horizontal: Dimensions.xLargePadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CountriesScreen()),
                            );
                          },
                          child: const Text('Paises'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
              /* Text(
                'Opciones',
                style: Theme.of(context).textTheme.headlineLarge, // Ajusta el estilo del texto según sea necesario
                textAlign: TextAlign.center,
              ), */
          /*     Padding(
                padding: const EdgeInsets.all(Dimensions.largePadding),
                child: Text(
                  'Elige una opción para continuar.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium, // Ajusta el estilo del texto según sea necesario
                ),
              ), Text(
                'Opciones',
                style: Theme.of(context).textTheme.headlineLarge, // Ajusta el estilo del texto según sea necesario
                textAlign: TextAlign.center,
              ), 
              */