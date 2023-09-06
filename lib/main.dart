import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'calc.dart';
void main() {
  runApp( Home());
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splashIconSize: 300,
            splash: Image.asset("assets/Mathlogo.png",),
            nextScreen: calc(),
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.rightToLeft,
            backgroundColor: Colors.black));
  
  }
}

