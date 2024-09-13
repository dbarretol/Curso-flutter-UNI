import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:myapp/utils/app_colors.dart';
import 'package:myapp/utils/dimensions.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light));

    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: SafeArea(
          //para que no se ocupe la barra de estado
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.mediumPadding),
            child: Column(
              children: [
                Text(
                  'Términos y condiciones',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: Dimensions.mediumPadding,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nunc varius, scelerisque dolor non, vestibulum sem. Praesent sit amet diam quis risus fringilla imperdiet sit amet nec sem. Vivamus urna eros, accumsan quis metus nec, posuere elementum sem. Duis fermentum, purus a interdum iaculis, eros mi aliquet velit, faucibus dignissim neque ligula sed orci. Suspendisse at placerat nibh, a feugiat odio. Vivamus vulputate eget urna vel aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque faucibus quam eget dui consequat, consequat commodo justo semper. Nullam eu lectus vel erat porttitor suscipit. Donec vitae est sapien. Etiam justo justo, scelerisque in metus in, laoreet pretium nunc.'
                            '\n\n'
                            'Vestibulum eleifend sollicitudin vulputate. Suspendisse ut elit massa. Proin laoreet condimentum justo, eget sollicitudin lectus sodales ac. Integer interdum velit quis quam imperdiet ultrices. Suspendisse potenti. Etiam hendrerit id neque id tincidunt. Morbi ligula turpis, rhoncus et euismod ut, auctor ac nisi. Aliquam blandit magna ut mi cursus hendrerit. Curabitur eget ante vel elit ullamcorper porta. Integer a lectus ultricies, porttitor arcu nec, porttitor ipsum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed pharetra lobortis ex. Pellentesque elementum erat vitae nunc volutpat pretium. Donec sit amet ligula et urna porttitor scelerisque at ut quam. Integer vitae felis dapibus, maximus justo ut, ornare nisi.'
                            '\n\n'
                            'Suspendisse euismod non leo vel fermentum. Vivamus quis semper dolor. Nulla neque tellus, consequat ac ligula a, egestas faucibus nisl. Sed faucibus porta neque sit amet congue. Ut sagittis augue augue, quis laoreet diam lobortis sit amet. Sed ipsum arcu, pharetra quis nunc id, consectetur imperdiet arcu. Sed interdum scelerisque porttitor. Proin et orci sit amet sapien malesuada malesuada. Vestibulum at scelerisque neque, quis scelerisque ex. Integer viverra, lacus vitae pretium lobortis, dolor sem consectetur purus, non tincidunt ipsum sem quis est. Nam vitae orci tincidunt, gravida orci aliquam, gravida augue. Integer at tincidunt felis. Cras vitae mollis sapien, et condimentum orci. Mauris rhoncus justo a vestibulum ultrices. Cras quam erat, sollicitudin at sagittis in, vestibulum ut quam.'
                            '\n\n'
                            'Donec et sollicitudin nunc. Morbi arcu ante, consectetur vel enim a, efficitur egestas ligula. Etiam quis maximus erat. Proin id elementum lorem. Donec ut feugiat elit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed quam arcu, sodales tempor tortor at, congue rutrum est.'),
                        const SizedBox(
                          height: Dimensions.mediumPadding,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); //Cierra la ventana
                            },
                            child: const Text('Cerrar')),
                        const SizedBox(
                          height: Dimensions.xLargePadding,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
