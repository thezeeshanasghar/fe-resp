import 'package:baby_receptionist/business_logic/blocs/AddExpenseBloc.dart';
import 'package:baby_receptionist/business_logic/blocs/AddPatientBloc.dart';
import 'package:baby_receptionist/business_logic/blocs/AppointmentListBloc.dart';
import 'package:baby_receptionist/business_logic/blocs/ExpenseListBloc.dart';
import 'package:baby_receptionist/business_logic/provider/LoginCredentialsProvider.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/presentation/router/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => LoginCredentialsProvider()),
        Provider<AddPatientBloc>(
          create: (_) => AddPatientBloc(),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<AddExpenseBloc>(
          create: (_) => AddExpenseBloc(),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<ExpenseListBloc>(
          create: (_) => ExpenseListBloc(),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<AppointmentListBloc>(
          create: (_) => AppointmentListBloc(),
          dispose: (context, value) => value.dispose(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Medics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
