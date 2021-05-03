import 'package:flutter/material.dart';
import 'package:baby_receptionist/receptionist/Home.dart';
import 'package:baby_receptionist/receptionist/addPatient.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/addPatient': (context) => AddPatient(),
      '/': (context) => Home(),
    },
  ));
}
