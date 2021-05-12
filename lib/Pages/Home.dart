import 'package:baby_receptionist/Design/Color.dart';
import 'package:baby_receptionist/Pages/AddPatient.dart';
import 'package:baby_receptionist/Pages/ExpenseList.dart';
import 'package:baby_receptionist/Pages/LoginScreen.dart';
import 'package:baby_receptionist/Pages/NewExpense.dart';
import 'package:baby_receptionist/Pages/OnCallList.dart';
import 'package:baby_receptionist/Pages/PatientList.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return HomeDrawer();
  }
}

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String appBarTitle = 'New Patient';
  bool newPatient = true;
  bool patientList = false;
  bool newExpense = false;
  bool expenseList = false;
  bool onCallList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.blueGrey,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Shade.drawerHeaderColor,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/receptionistHeader.jpg'),
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        'Syed Basit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                  leading: Icon(Icons.add_circle_outlined),
                  title: Text('New Patient'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      appBarTitle = 'New Patient';
                      newPatient = true;
                      patientList = false;
                      newExpense = false;
                      expenseList = false;
                      onCallList = false;
                    });
                  }),
              ListTile(
                  leading: Icon(Icons.list_alt_outlined),
                  title: Text('Patient List'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      appBarTitle = 'Patient List';
                      newPatient = false;
                      patientList = true;
                      newExpense = false;
                      expenseList = false;
                      onCallList = false;
                    });
                  }),
              ListTile(
                  leading: Icon(Icons.fiber_new_outlined),
                  title: Text('New Expense'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      appBarTitle = 'New Expense';
                      newPatient = false;
                      patientList = false;
                      newExpense = true;
                      expenseList = false;
                      onCallList = false;
                    });
                  }),
              ListTile(
                  leading: Icon(Icons.line_style_outlined),
                  title: Text('Expense List'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      appBarTitle = 'Expense List';
                      newPatient = false;
                      patientList = false;
                      newExpense = false;
                      expenseList = true;
                      onCallList = false;
                    });
                  }),
              ListTile(
                  leading: Icon(Icons.contact_phone_outlined),
                  title: Text('On Call List'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      appBarTitle = 'On Call List';
                      newPatient = false;
                      patientList = false;
                      newExpense = false;
                      expenseList = false;
                      onCallList = true;
                    });
                  }),
              ListTile(
                  leading: Icon(Icons.login_outlined),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    });
                  })
            ],
          ),
        ),
        body: selectMainBodyWidget());
  }

  Widget selectMainBodyWidget() {
    if (newPatient) {
      return AddPatient();
    } else if (patientList) {
      return PatientList();
    } else if (newExpense) {
      return NewExpense();
    } else if (expenseList) {
      return ExpenseList();
    } else if (onCallList) {
      return OnCallList();
    }
  }
}
