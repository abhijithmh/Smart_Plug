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
      splash: Image(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2,
        image: NetworkImage('https://www.reviewgeek.com/p/uploads/2020/02/9aed2ae7.png?width=1200'),
      ),
      nextScreen: mainscreen(),
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
