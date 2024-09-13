import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/screens/welcome_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _inicioAnimacion = false;

  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
    _startAnimation();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 7));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()));
  }

  _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _inicioAnimacion = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: LayoutBuilder(builder: (context, constrains) {
        double screenHeight = constrains.maxHeight;

        double logoHeight = 240;
        double finalPosition = (screenHeight - logoHeight) / 2;

        return Stack(fit: StackFit.expand, children: [
          AnimatedPositioned(
              duration: const Duration(seconds: 3),
              curve: Curves.easeInOut,
              bottom: _inicioAnimacion ? finalPosition : -logoHeight,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _inicioAnimacion ? 1 : 0,
                duration: const Duration(seconds: 4),
                child: Center(
                    child: Image.asset(
                  'assets/images/logo_loki.png',
                  height: logoHeight,
                )),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: Dimensions.mediumPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hola',
                        //style: TextStyle(fontSize: 72, fontWeight: FontWeight.w200, color: Colors.red)
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WelcomeScreen()));
                          },
                          child: const Text("Bienvenido"))
                    ],
                  )))
        ]);
      })),
    );
  }
}

/*
Codigo optimziado

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/screens/welcome_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/dimensions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _inicioAnimacion = false;

  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
    _startAnimation();
  }

  Future<void> _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 7));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _inicioAnimacion = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double logoHeight = 240;
          double finalPosition = (screenHeight - logoHeight) / 2;

          return Stack(
            fit: StackFit.expand,
            children: [
              _buildAnimatedLogo(logoHeight, finalPosition),
              _buildBottomSection(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedLogo(double logoHeight, double finalPosition) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOut,
      bottom: _inicioAnimacion ? finalPosition : -logoHeight,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _inicioAnimacion ? 1 : 0,
        duration: const Duration(seconds: 4),
        child: Center(
          child: Image.asset(
            'assets/images/logo_loki.png',
            height: logoHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.mediumPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hola',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              },
              child: const Text("Bienvenido"),
            ),
          ],
        ),
      ),
    );
  }
}


*/