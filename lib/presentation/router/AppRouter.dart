import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/pages/invoice/InvoiceList.dart';
import 'package:baby_receptionist/presentation/pages/patient/AddPatient.dart';
import 'package:baby_receptionist/presentation/pages/expense/EditExpense.dart';
import 'package:baby_receptionist/presentation/pages/expense/ExpenseList.dart';
import 'package:baby_receptionist/presentation/pages/Home.dart';
import 'package:baby_receptionist/presentation/pages/LoginScreen.dart';
import 'package:baby_receptionist/presentation/pages/expense/NewExpense.dart';
import 'package:baby_receptionist/presentation/pages/invoice/NewInvoice.dart';
import 'package:baby_receptionist/presentation/pages/patient/PatientList.dart';
import 'package:baby_receptionist/presentation/pages/Refund.dart';
import 'package:baby_receptionist/presentation/pages/appointment/AppointmentList.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/Home':
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case '/AddPatient':
        return MaterialPageRoute(
          builder: (_) => AddPatient(),
        );
      case '/ExpenseList':
        return MaterialPageRoute(
          builder: (_) => ExpenseList(),
        );
      case '/NewExpense':
        return MaterialPageRoute(
          builder: (_) => NewExpense(),
        );
      case QString.routeEditExpense:
        final arguments = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => EditExpense(
            arguments: arguments,
          ),
        );
      case '/PatientList':
        return MaterialPageRoute(
          builder: (_) => PatientList(),
        );
      case QString.routeNewInvoice:
        final arguments = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => NewInvoice(
            arguments: arguments,
          ),
        );
      case '/Refund':
        return MaterialPageRoute(
          builder: (_) => Refund(),
        );
      case QString.routeAppointmentList:
        return MaterialPageRoute(
          builder: (_) => AppointmentList(),
        );
      case QString.routeInvoiceList:
        return MaterialPageRoute(
          builder: (_) => InvoiceList(),
        );
      default:
        return null;
    }
  }
}
