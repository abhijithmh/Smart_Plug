import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../Variables/colors.dart';

class infoScreen extends StatelessWidget {
   infoScreen({Key? key}) : super(key: key);
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.purple,Colors.deepPurple.shade700, Colors.deepPurple.shade900],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 300, 100));
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
                    color: Colors.white,
                    fontSize: 40,
                  ),
                )),
          ),
        ),
        backgroundColor: appbarColor,
      ),
      body : StreamBuilder(
          stream: FirebaseFirestore.instance.collection('smart_plug').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              String Current = snapshot.data!.docs.elementAt(0).get("current");
              String Energy = snapshot.data!.docs.elementAt(0).get("energy");
              String Frequency =
                  snapshot.data!.docs.elementAt(0).get("frequency");
              String Pf = snapshot.data!.docs.elementAt(0).get("pf");
              String Power = snapshot.data!.docs.elementAt(0).get("power");
              String Temperature =
                  snapshot.data!.docs.elementAt(0).get("temperature");
              String Voltage = snapshot.data!.docs.elementAt(0).get("voltage");

              double current = double.parse(Current);
              double voltage = double.parse(Voltage);
              double temperature = double.parse(Temperature);
              double frequency = double.parse(Frequency);
              double pf = double.parse(Pf);
              double power = double.parse(Power);
              double energy = double.parse(Energy);

              return SingleChildScrollView(
                child: ListBody(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'CURRENT',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: [
                              RadialAxis(minimum: 0, maximum: 20, pointers: [
                                NeedlePointer(
                                    enableAnimation: true,
                                    value: current,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    needleLength: 0.8,
                                    needleEndWidth: 5,
                                    gradient: const LinearGradient(colors: <Color>[
                                      Color(0xFFFF6B78),
                                      Color(0xFFFF6B78),
                                      Color(0xFFE20A22),
                                      Color(0xFFE20A22)
                                    ], stops: <double>[
                                      0,
                                      0.5,
                                      0.5,
                                      1
                                    ]),
                                    needleColor: const Color(0xFFE06C78),
                                    knobStyle: const KnobStyle(
                                        knobRadius: 0.08,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: Colors.black)),
                              ], ranges: [
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 16,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 16, endValue: 20, color: Colors.red)
                              ], annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.7,
                                    angle: 90,
                                    widget: Text(
                                      current.toString() + ' A',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ))
                              ])
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'VOLTAGE',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: [
                              RadialAxis(minimum: 0, maximum: 300, pointers: [
                                NeedlePointer(
                                    enableAnimation: true,
                                    value: voltage,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    needleLength: 0.8,
                                    needleEndWidth: 5,
                                    gradient: const LinearGradient(colors: <Color>[
                                      Color(0xFFFF6B78),
                                      Color(0xFFFF6B78),
                                      Color(0xFFE20A22),
                                      Color(0xFFE20A22)
                                    ], stops: <double>[
                                      0,
                                      0.5,
                                      0.5,
                                      1
                                    ]),
                                    needleColor: const Color(0xFFF67280),
                                    knobStyle: const KnobStyle(
                                        knobRadius: 0.08,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: Colors.black)),
                              ], ranges: [
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 100,
                                    color: Colors.red),
                                GaugeRange(
                                    startValue: 100,
                                    endValue: 250,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 250,
                                    endValue: 300,
                                    color: Colors.red)
                              ], annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.7,
                                    angle: 90,
                                    widget: Text(
                                      voltage.toString() + ' V',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ))
                              ])
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'TEMPERARTURE',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: [
                              RadialAxis(minimum: 0, maximum: 100, pointers: [
                                NeedlePointer(
                                    enableAnimation: true,
                                    value: temperature,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    needleLength: 0.8,
                                    needleEndWidth: 5,
                                    gradient: const LinearGradient(colors: <Color>[
                                      Color(0xFFFF6B78),
                                      Color(0xFFFF6B78),
                                      Color(0xFFE20A22),
                                      Color(0xFFE20A22)
                                    ], stops: <double>[
                                      0,
                                      0.5,
                                      0.5,
                                      1
                                    ]),
                                    needleColor: const Color(0xFFF67280),
                                    knobStyle: const KnobStyle(
                                        knobRadius: 0.08,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: Colors.black)),
                              ], ranges: [
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 15,
                                    color: Colors.red),
                                GaugeRange(
                                    startValue: 15,
                                    endValue: 60,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 60,
                                    endValue: 100,
                                    color: Colors.red)
                              ], annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.7,
                                    angle: 90,
                                    widget: Text(
                                      temperature.toString() + ' °C',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ))
                              ])
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'FREQUENCY',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: [
                              RadialAxis(minimum: 30, maximum: 80, pointers: [
                                NeedlePointer(
                                    enableAnimation: true,
                                    value: frequency,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    needleLength: 0.8,
                                    needleEndWidth: 5,
                                    gradient: const LinearGradient(colors: <Color>[
                                      Color(0xFFFF6B78),
                                      Color(0xFFFF6B78),
                                      Color(0xFFE20A22),
                                      Color(0xFFE20A22)
                                    ], stops: <double>[
                                      0,
                                      0.5,
                                      0.5,
                                      1
                                    ]),
                                    needleColor: const Color(0xFFF67280),
                                    knobStyle: const KnobStyle(
                                        knobRadius: 0.08,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: Colors.black)),
                              ], ranges: [
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 45,
                                    color: Colors.red),
                                GaugeRange(
                                    startValue: 45,
                                    endValue: 65,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 65, endValue: 80, color: Colors.red)
                              ], annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.7,
                                    angle: 90,
                                    widget: Text(
                                      frequency.toString() + ' Hz',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ))
                              ])
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'ENERGY',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: <RadialAxis>[
                          RadialAxis(minimum:0,maximum:1000,pointers: <GaugePointer>[
                            RangePointer(value: energy, dashArray: <double>[8, 2],
                            color: Colors.green,)
                          ], annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.0,
                                angle: 90,
                                widget: Text(
                                  energy.toString() + ' kWh',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ))
                          ])
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'POWER FACTOR',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: <RadialAxis>[
                              RadialAxis(minimum:0,maximum:1,pointers: <GaugePointer>[
                                RangePointer(value: pf, dashArray: <double>[8, 2],
                                  color: Colors.green,)
                              ], annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.0,
                                    angle: 90,
                                    widget: Text(
                                      pf.toString(),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ))
                              ])
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 750,
                            title:  GaugeTitle(
                              alignment: GaugeAlignment.near,
                              text: 'POWER',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  foreground: Paint()..shader = linearGradient,
                                  fontFamily: 'Times'),
                            ),
                            axes: <RadialAxis>[
                              RadialAxis(minimum:0,maximum:1000,pointers: <GaugePointer>[
                                RangePointer(value: power, dashArray: <double>[8, 2],
                                  color: Colors.green,)
                              ], annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.0,
                                    angle: 90,
                                    widget: Text(
                                      power.toString() + ' W',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ))
                              ])
                            ]),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
