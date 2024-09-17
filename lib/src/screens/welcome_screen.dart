import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/components/heading_image.dart';
import 'package:myapp/src/screens/start_screen.dart';
import 'package:myapp/src/screens/options_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/dimensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeadingImage(
                  imagePath: 'assets/images/foto_welcome.jpg', title: "Hola"),
              Text(
                'Mi app',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.all(Dimensions.largePadding),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nunc varius, scelerisque dolor non, vestibulum sem. Praesent sit amet diam quis risus fringilla imperdiet sit amet nec sem.',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.tinyPadding,
                      horizontal: Dimensions.mediumPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StartScreen()));
                      },
                      child: const Text('Empezar'),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.tinyPadding,
                      horizontal: Dimensions.mediumPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OptionsScreen()));
                      },
                      child: const Text('Opciones'),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
             /* Reemplazado por HeadingImage
             
              Stack(
                children: [
                  SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: Image.asset('assets/images/foto_welcome.jpg',
                          fit: BoxFit.cover)),
                  Positioned(
                      bottom: Dimensions.mediumPadding,
                      right: Dimensions.mediumPadding,
                      child: Text("Bienvenido",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: AppColors.onPrimary)))
                ],
              ),*/