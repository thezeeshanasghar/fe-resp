import 'package:flutter/material.dart';
import 'package:baby_receptionist/Pages/Home.dart';
import 'package:baby_receptionist/Pages/addPatient.dart';
import 'package:baby_receptionist/Pages/Expense.dart';
import 'package:baby_receptionist/Pages/NewExpense.dart';
import 'package:baby_receptionist/Pages//PatientList.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/addPatient': (context) => AddPatient(),
      '/Expense': (context) => Expense(),
      '/NewExpense': (context) => NewExpense(),
      '/PatientList': (context) => PatientList(),
      '/': (context) => Home(),
    },
  ));
}
