import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'main.dart';
class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3,
      splash: Text("splash"),
      nextScreen: mainscreen(),
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
