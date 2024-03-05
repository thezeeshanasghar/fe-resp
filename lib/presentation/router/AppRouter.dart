
import 'package:flutter/material.dart';

import '../constants/QString.dart';
import '../pages/Home.dart';
import '../pages/LoginScreen.dart';
import '../pages/Refund.dart';
import '../pages/appointment/AppointmentList.dart';
import '../pages/expense/EditExpense.dart';
import '../pages/expense/ExpenseList.dart';
import '../pages/expense/NewExpense.dart';
import '../pages/invoice/InvoiceList.dart';
import '../pages/invoice/NewInvoice.dart';
import '../pages/patient/AddPatient.dart';
import '../pages/patient/PatientList.dart';

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
      // case '/AddPatient':
      //   return MaterialPageRoute(
      //     builder: (_) => AddPatient(),
      //   );
      // case '/ExpenseList':
      //   return MaterialPageRoute(
      //     builder: (_) => ExpenseList(),
      //   );
      case '/NewExpense':
        return MaterialPageRoute(
          builder: (_) => NewExpense(),
        );
      // case QString.routeEditExpense:
      //   final arguments = settings.arguments;
      //   return MaterialPageRoute(
      //     builder: (_) => EditExpense(
      //       arguments: arguments,
      //     ),
      //   );
      // case '/PatientList':
      //   return MaterialPageRoute(
      //     builder: (_) => PatientList(),
      //   );
      // case QString.routeNewInvoice:
      //   final arguments = settings.arguments;
      //   return MaterialPageRoute(
      //     builder: (_) => NewInvoice(
      //       arguments: arguments,
      //     ),
      //   );
      // case '/Refund':
      //   return MaterialPageRoute(
      //     builder: (_) => Refund(),
      //   );
      // case QString.routeAppointmentList:
      //   return MaterialPageRoute(
      //     builder: (_) => AppointmentList(),
      //   );
      // case QString.routeInvoiceList:
      //   return MaterialPageRoute(
      //     builder: (_) => InvoiceList(),
      //   );
      default:
        return null!;
    }
  }
}
