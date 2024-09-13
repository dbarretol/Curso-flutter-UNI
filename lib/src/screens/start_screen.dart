import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/components/heading_image.dart';
import 'package:myapp/src/screens/home_screen.dart';
import 'package:myapp/src/screens/terms_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/dimensions.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

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
                  imagePath: 'assets/images/foto_start.jpg', title: 'Iniciar'),
              Text(
                'Inicie',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Padding(
                padding: EdgeInsets.all(Dimensions.largePadding),
                child: Text(
                  textAlign: TextAlign.center,
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nunc varius, scelerisque dolor non, vestibulum sem. Praesent sit amet diam quis risus fringilla imperdiet sit amet nec sem.'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsScreen()));
                    },
                    child: const Text('Términos'),
                  ),
                  const SizedBox(
                    width:
                        Dimensions.smallPadding, //Agrega espacio entre botnoes
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: const Text('Inicio'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
              /* Reemplazado por HeadingImage


              SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Image.asset('assets/images/foto_start.jpg',
                      fit: BoxFit.cover)),*/