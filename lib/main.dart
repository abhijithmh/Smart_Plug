import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_plug/screens/PlugScreen.dart';
import 'package:smart_plug/screens/homeScreen.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: splashScreen());
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
  final pages = [homeScreen(), plugScreen()];
  String Heading = 'SmartPlug';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            child: Text(Heading,
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  textStyle: TextStyle(
                    color: Colors.greenAccent[100],
                    fontSize: 30,
                  ),
                )),
          ),
        ),
        backgroundColor: appbarColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
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
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Set Values'),
        ],
      ),
      body: pages[currentSelection],
    );
  }
}
