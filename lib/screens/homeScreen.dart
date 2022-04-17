import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Variables/colors.dart';

class homeScreen extends StatefulWidget {
  homeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Colors.purple,
      Colors.deepPurple.shade700,
      Colors.deepPurple.shade900
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 300, 100));
  void power(bool state) {
    FirebaseFirestore.instance.collection("smart_plug").doc("relay").update({
      relayselected[ind].toString(): state.toString(),
    });
  }

  final List<bool> isSelected = [true, false, false, false];
  final List<String> relayselected = ['relay1', 'relay2', 'relay3', 'relay4'];
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                // constraints variable has the size info
                return Container();
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
              child: ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(
                          'PLUG',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '1',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(
                          'PLUG',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '2',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(
                          'PLUG',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '3',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(
                          'PLUG',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '4',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                        ind = index;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
                fillColor: appbarColor,
                selectedColor: Colors.white,
                renderBorder: false,
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('smart_plug')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    String Relay = snapshot.data!.docs
                        .elementAt(1)
                        .get(relayselected[ind]);
                    if (Relay == 'true') {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
                            child: Text('SMART PLUG',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(
                                  textStyle: TextStyle(
                                      foreground: Paint()
                                        ..shader = linearGradient,
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SizedBox(
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.green[700],
                                        primary: Colors.white,
                                        elevation: 20,
                                        shape: const CircleBorder()),
                                    onPressed: () {
                                      power(false);
                                    },
                                    child: const Icon(
                                      Icons.settings_power_outlined,
                                      size: 100,
                                    )),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 30,
                            ),
                          ),
                          Text('ON',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                    color: Colors.pink[900],
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      );
                    } else if (Relay == 'false') {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
                            child: Text('SMART PLUG',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(
                                  textStyle: TextStyle(
                                      foreground: Paint()
                                        ..shader = linearGradient,
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SizedBox(
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.red[900],
                                        primary: Colors.white,
                                        elevation: 10,
                                        shape: const CircleBorder()),
                                    onPressed: () {
                                      power(true);
                                    },
                                    child: const Icon(
                                      Icons.power_settings_new_outlined,
                                      size: 100,
                                    )),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 30,
                            ),
                          ),
                          Text('OFF',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                    color: Colors.pink[900],
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
