import 'dart:async';

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

  TextEditingController ctrl = TextEditingController();

  var dry;

  @override
  void initState() {

    // get data from database every second
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dry != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.fill),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Column(
            // create a column
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: ctrl,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Dryness',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                enabled: false,
              ),
              SizedBox(height: 25), // make a space betwwen this 2 widgets
              customWidget('Device'),
            ],
          ),
        ),
      );
    }

    // if Internet connection is not established, 
    // show loading animation
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // custom Widget that contains a text and 2 raised button
  // take one parameter which is used to be displayed also
  // the key in the firebased
  Widget customWidget(String device) {
    return Column(
      children: <Widget>[
        Text(
          device,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                  // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: Colors.black),
              Shadow(
                  // bottomRight
                  offset: Offset(1.5, -1.5),
                  color: Colors.black),
              Shadow(
                  // topRight
                  offset: Offset(1.5, 1.5),
                  color: Colors.black),
              Shadow(
                  // topLeft
                  offset: Offset(-1.5, 1.5),
                  color: Colors.black),
            ],
          ),
        ),
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

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      dry = data['Dryness'];

      // refresh the UI
      setState(() {
        ctrl.text = dry.toString();
      });
    });
  }
}
