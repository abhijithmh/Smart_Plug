import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Variables/colors.dart';

class plugScreen extends StatefulWidget {
  plugScreen({Key? key}) : super(key: key);

  @override
  State<plugScreen> createState() => _plugScreenState();
}

class _plugScreenState extends State<plugScreen> {

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Colors.purple,
      Colors.deepPurple.shade700,
      Colors.deepPurple.shade900
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 300, 100));
  void addTask() {
    FirebaseFirestore.instance.collection("smart_plug").doc("variables").set({
      's_current': s_current,
      's_voltage': s_voltage,
      'Su_voltage': Su_voltage,
      'T_temperature': T_temperature,
      'flag': 'true'
    });
  }
  double s_current = 15;
  double s_voltage =240;
  double Su_voltage = 120;
  double T_temperature = 40;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Center(
          child: Container(
            child: Text('SMART PLUG',
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
      body:  SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'VOLTAGE UPPER LIMIT: ' + s_voltage.toString(),
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(
                            foreground: Paint()
                              ..shader = linearGradient,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Slider(
                      value: s_voltage,
                      min: 100,
                      max: 250,
                      divisions: 300,
                      activeColor: Colors.red,
                      inactiveColor: Colors.blue,
                      label: s_voltage.toString(),
                      onChanged: (s_voltage) =>
                          setState(() => this.s_voltage = s_voltage),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'CURRENT : ' + s_current.toString(),
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(
                            foreground: Paint()
                              ..shader = linearGradient,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Slider(
                      value: s_current,
                      min: 0,
                      max: 20,
                      divisions: 100,
                      activeColor: Colors.red,
                      inactiveColor: Colors.blue,
                      label: s_current.toString(),
                      onChanged: (s_current) =>
                          setState(() => this.s_current = s_current),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'VOLTAGE LOWER LIMIT : ' + Su_voltage.toString(),
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(
                            foreground: Paint()
                              ..shader = linearGradient,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Slider(
                      value: Su_voltage,
                      min: 0,
                      max: 250,
                      divisions: 250,
                      activeColor: Colors.red,
                      inactiveColor: Colors.blue,
                      label: Su_voltage.toString(),
                      onChanged: (Su_voltage) =>
                          setState(() => this.Su_voltage = Su_voltage),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('TEMPERATURE : ' + T_temperature.toString(),
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(
                            foreground: Paint()
                              ..shader = linearGradient,
                            fontSize: 20,
                          ),),),
                    ),
                    Slider(
                      value: T_temperature,
                      min: 10,
                      max: 50,
                      divisions: 40,
                      activeColor: Colors.red,
                      inactiveColor: Colors.blue,
                      label: T_temperature.round().toString(),
                      onChanged: (T_temperature) =>
                          setState(() => this.T_temperature = T_temperature),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            backgroundColor: Colors.deepPurple,
                            primary: Colors.white,
                          ),
                          onPressed: addTask,
                          child: Text('SET VALUES',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
  }
}
