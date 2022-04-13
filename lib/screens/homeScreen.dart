import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Variables/colors.dart';

class homeScreen extends StatefulWidget {
  homeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  void poweroff(String state) {
    FirebaseFirestore.instance.collection("smart_plug").doc("relay").set({
      'relay': 'false',
    });
  }

  void poweron(String state) {
    FirebaseFirestore.instance.collection("smart_plug").doc("relay").set({
      'relay': 'true',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('smart_plug')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  String relay =
                      snapshot.data!.docs.elementAt(1).get("relay");
                  if (relay == 'true') {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: SizedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    primary: Colors.white,
                                    elevation: 10,
                                    shape: CircleBorder()),
                                onPressed: () {
                                  poweroff(relay);
                                },
                                child: Text('POWER OFF'),
                              ),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 3),
                        ),
                        Text('THE SMART PLUG IS ON'),
                      ],
                    );
                  } else if (relay == 'false') {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: SizedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    primary: Colors.white,
                                    elevation: 10,
                                    shape: CircleBorder()),
                                onPressed: () {
                                  poweron(relay);
                                },
                                child: Text('POWER ON'),
                              ),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 3),
                        ),
                        Text('THE SMART PLUG IS OFF'),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              }),
        ],
      ),
    );
  }
}
