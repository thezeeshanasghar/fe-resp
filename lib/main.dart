import 'package:baby_receptionist/Pages/LoginScreen.dart';
import 'package:baby_receptionist/Pages/NewInvoice.dart';
import 'package:baby_receptionist/Pages/OnCallList.dart';
import 'package:baby_receptionist/Pages/Refund.dart';
import 'package:baby_receptionist/Pages/Shift.dart';
import 'package:baby_receptionist/Providers/LoginCredentialsProvider.dart';
import 'package:baby_receptionist/Providers/TokenProvider.dart';
import 'package:flutter/material.dart';
import 'package:baby_receptionist/Pages/Home.dart';
import 'package:baby_receptionist/Pages/AddPatient.dart';
import 'package:baby_receptionist/Pages/ExpenseList.dart';
import 'package:baby_receptionist/Pages/NewExpense.dart';
import 'package:baby_receptionist/Pages//PatientList.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => LoginCredentialsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      initialRoute: '/LoginScreen',
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
    );
  }

}
