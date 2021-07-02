import 'package:baby_receptionist/Pages/LoginScreen.dart';
import 'package:baby_receptionist/Pages/NewInvoice.dart';
import 'package:baby_receptionist/Pages/OnCallList.dart';
import 'package:baby_receptionist/Pages/Refund.dart';
import 'package:baby_receptionist/Pages/Shift.dart';
import 'package:flutter/material.dart';
import 'package:baby_receptionist/Pages/Home.dart';
import 'package:baby_receptionist/Pages/AddPatient.dart';
import 'package:baby_receptionist/Pages/ExpenseList.dart';
import 'package:baby_receptionist/Pages/NewExpense.dart';
import 'package:baby_receptionist/Pages//PatientList.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/Home',
    routes: {
      '/AddPatient': (context) => AddPatient(),
      '/ExpenseList': (context) => ExpenseList(),
      '/NewExpense': (context) => NewExpense(),
      '/PatientList': (context) => PatientList(),
      '/NewInvoice': (context) => NewInvoice(),
      '/Refund': (context) => Refund(),
      '/OnCallList': (context) => OnCallList(),
      '/LoginScreen': (context) => LoginScreen(),
      '/Home': (context) => Home(),
      '/Shift': (context) => ShiftScreen(),
    },
  ));
}
