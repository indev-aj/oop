import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // the instance of the database reference
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Column(      // create a column
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customWidget('Device'),
            SizedBox(height: 25), // make a space betwwen this 2 widgets
            customWidget('Motor'),
          ],
        ),
      ),
    );
  }

  // custom Widget that contains a text and 2 raised button
  // take one parameter which is used to be displayed also
  // the key in the firebased
  Widget customWidget(String device) {
    return Column(
      children: <Widget>[
        Text(device),
        RaisedButton(
          onPressed: () => updateData(device, 1),
          child: Text('ON'),
        ),
        RaisedButton(
          onPressed: () => updateData(device, 0),
          child: Text('OFF'),
        ),
      ],
    );
  }

  // update the value in the database
  void updateData(String key, int value) =>
      databaseReference.update({key: value});
}
