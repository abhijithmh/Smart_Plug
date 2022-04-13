import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class plugScreen extends StatefulWidget {
  plugScreen({Key? key}) : super(key: key);

  @override
  State<plugScreen> createState() => _plugScreenState();
}

class _plugScreenState extends State<plugScreen> {
  void addTask() {
    FirebaseFirestore.instance.collection("smart_plug").doc("data").set({
      's_current': s_current,
      's_voltage': s_voltage,
      'Su_voltage': Su_voltage,
      'T_temperature': T_temperature,
      'flag': 'true',
      'current': 0,
      "energy": 0,
      'frequency': 0,
      'pf': 0,
      'power': 0,
      'relay': 'false',
      'temperature': 0,
      'voltage': 0,
    });
  }
  void getDAta()async{
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('smart_plug').doc('data').get();
    s_voltage= variable['s_voltage'];
    Su_voltage=variable['Su_voltage'];
    T_temperature=variable['T_temperature'];
  }

  double s_current = 1;
  double s_voltage = 100;
  double Su_voltage = 120;
  double T_temperature = 40;
  @override
  void initState(){
   getDAta();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                primary: Colors.white,
              ),
              onPressed: addTask,
              child: Text('SET VALUES'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('S_voltage : ' + s_voltage.toString()),
              ],
            ),
          ),
          Slider(
            value: s_voltage,
            min: 100,
            max: 250,
            divisions: 150,
            activeColor: Colors.red,
            inactiveColor: Colors.blue,
            label: s_voltage.round().toString(),
            onChanged: (s_voltage) =>
                setState(() => this.s_voltage = s_voltage),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('S_current : ' + s_current.toString()),
              ],
            ),
          ),
          Slider(
            value: s_current,
            min: 0,
            max: 20,
            divisions: 20,
            activeColor: Colors.red,
            inactiveColor: Colors.blue,
            label: s_current.round().toString(),
            onChanged: (s_current) =>
                setState(() => this.s_current = s_current),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Su_voltage : ' + Su_voltage.toString()),
              ],
            ),
          ),
          Slider(
            value: Su_voltage,
            min: 0,
            max: 250,
            divisions: 250,
            activeColor: Colors.red,
            inactiveColor: Colors.blue,
            label: Su_voltage.round().toString(),
            onChanged: (Su_voltage) =>
                setState(() => this.Su_voltage = Su_voltage),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('T_temperature : ' + T_temperature.toString()),
              ],
            ),
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
        ],
      ),
    );
  }
}
