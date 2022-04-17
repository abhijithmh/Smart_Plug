import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_plug/screens/homeScreen.dart';
import 'package:smart_plug/screens/PlugScreen.dart';
import 'package:smart_plug/screens/infoScreen.dart';
import 'package:smart_plug/splash.dart';

import 'Variables/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const splashScreen());
  }
}

class mainscreen extends StatefulWidget {
  mainscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int currentSelection = 0;
  final pages = [homeScreen(), infoScreen(), plugScreen()];
  String Heading = 'SMART PLUG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple[200],
        selectedItemColor: Colors.white70,
        selectedIconTheme: IconThemeData(color: Colors.white),
        currentIndex: currentSelection,
        onTap: (newIdex) {
          setState(() {
            currentSelection = newIdex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Set Values'),
        ],
      ),
      body: pages[currentSelection],
    );
  }
}
