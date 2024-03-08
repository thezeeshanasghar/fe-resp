
import 'package:fe_resp/presentation/pages/LoginScreen.dart';
import 'package:fe_resp/presentation/router/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';



import 'business_logic/provider/LoginCredentialsProvider.dart';
import 'business_logic/provider/TokenProvider.dart';

void main() {
  runApp(
    // MultiProvider(
    //   providers: [
    //     // ChangeNotifierProvider(create: (_) => TokenProvider()),
    //     // ChangeNotifierProvider(create: (_) => LoginCredentialsProvider()),
    //     // Provider<AddPatientBloc>(
    //     //   create: (_) => AddPatientBloc(),
    //     //   dispose: (context, value) => value.dispose(),
    //     // ),
    //     // Provider<AddExpenseBloc>(
    //     //   create: (_) => AddExpenseBloc(),
    //     //   dispose: (context, value) => value.dispose(),
    //
    //     // Provider<ExpenseListBloc>(
    //     //   create: (_) => ExpenseListBloc(),
    //     //   dispose: (context, value) => value.dispose(),
    //     // ),
    //     // Provider<AppointmentListBloc>(
    //     //   create: (_) => AppointmentListBloc(),
    //     //   dispose: (context, value) => value.dispose(),
    //     // ),
    //   ],
      MyApp(),

  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Medics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
