import 'package:baby_receptionist/data/models/Requests/ExpenseRequest.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/pages/AddPatient.dart';
import 'package:baby_receptionist/presentation/pages/EditExpense.dart';
import 'package:baby_receptionist/presentation/pages/ExpenseList.dart';
import 'package:baby_receptionist/presentation/pages/Home.dart';
import 'package:baby_receptionist/presentation/pages/LoginScreen.dart';
import 'package:baby_receptionist/presentation/pages/NewExpense.dart';
import 'package:baby_receptionist/presentation/pages/NewInvoice.dart';
import 'package:baby_receptionist/presentation/pages/OnCallList.dart';
import 'package:baby_receptionist/presentation/pages/PatientList.dart';
import 'package:baby_receptionist/presentation/pages/Refund.dart';
import 'package:baby_receptionist/presentation/pages/appointment/appointment_list/AppointmentList.dart';
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
      case '/NewInvoice':
        return MaterialPageRoute(
          builder: (_) => NewInvoice(),
        );
      case '/Refund':
        return MaterialPageRoute(
          builder: (_) => Refund(),
        );
      case '/OnCallList':
        return MaterialPageRoute(
          builder: (_) => OnCallList(),
        );
      case QString.routeAppointmentList:
        return MaterialPageRoute(
          builder: (_) => AppointmentList(),
        );
      default:
        return null;
    }
  }
}
