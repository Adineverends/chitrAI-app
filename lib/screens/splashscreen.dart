import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chitrai/screens/home.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: 'images/logo2.png',
        splashIconSize: 230,
        splashTransition: SplashTransition.scaleTransition,
        //pageTransitionType:PageTransitionsTheme.,
        nextScreen: home()
    );
  }
}
