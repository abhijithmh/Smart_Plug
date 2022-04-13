import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class infoScreen extends StatelessWidget {
  const infoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('smart_plug').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            double altitude =
                snapshot.data!.docs.elementAt(0).get("Su_voltage");
            double ripecount =
                snapshot.data!.docs.elementAt(0).get("T_temperature");
            double unripecount =
                snapshot.data!.docs.elementAt(0).get("s_voltage");
            final items = [altitude, ripecount, unripecount];

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].toString()),
                  );
                });
          }
        });
  }
}
