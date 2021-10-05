import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/presentation/Pages/LoginScreen.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: QColor.globalBackgroundColor,
        appBar: AppBar(
          title: Text(QString.titleHomePage),
          backgroundColor: QColor.globalAppBarColor,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: QColor.drawerHeaderColor,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/joker.jpg'),
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        'Receptionist 1',
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
                title: Text(QString.titleAddPatient),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, QString.routeAddPatient);
                },
              ),
              ListTile(
                  leading: Icon(Icons.list_alt_outlined),
                  title: Text(QString.titlePatientList),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, QString.routePatientList);
                  }),
              ListTile(
                leading: Icon(Icons.fiber_new_outlined),
                title: Text(QString.titleAddExpense),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, QString.routeNewExpense);
                },
              ),
              ListTile(
                  leading: Icon(Icons.line_style_outlined),
                  title: Text(QString.titleExpenseList),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, QString.routeExpenseList);
                  }),
              ListTile(
                  leading: Icon(Icons.login_outlined),
                  title: Text('Logout'),
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  })
            ],
          ),
        ),
        body: Scaffold(
          backgroundColor: Colors.grey[100],
          body: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2,
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.minHeight,
                        minWidth: viewportConstraints.minWidth),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            QPadding.globalPaddingLeft,
                            QPadding.globalPaddingTop,
                            QPadding.globalPaddingRight,
                            QPadding.globalPaddingBottom),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              widgetRowHeaderOne(),
                              widgetRowOne(),
                              widgetRowHeaderTwo(),
                              widgetRowThree(),
                              widgetRowFour(),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget widgetRowHeaderOne() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'For adding data in database',
                            style: QTextStyle.homeHeader,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetRowHeaderTwo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'To view data that is present in database',
                            style: QTextStyle.homeHeader,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetRowOne() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetAddPatient(),
        widgetAddExpense(),
        widgetDummySpaceCard(),
      ],
    );
  }

  Widget widgetRowThree() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetPatientListCard(),
        widgetAppointmentListCard(),
        widgetInvoiceListCard(),
      ],
    );
  }

  Widget widgetRowFour() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetExpenseListCard(),
        widgetDummySpaceCard(),
        widgetDummySpaceCard(),
      ],
    );
  }

  Widget widgetRowFive() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetPatientListCard(),
        widgetExpenseListCard(),
        widgetOnCallListCard(),
      ],
    );
  }

  Widget widgetDummySpaceCard() {
    return Expanded(
      child: Text(
        'Click to create the account of a doctor',
        style: TextStyle(color: QColor.globalBackgroundColor),
      ),
    );
  }

  Widget widgetPatientListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routePatientList);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titlePatientList,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAppointmentListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routeAppointmentList);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titleAppointmentList,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetInvoiceListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routeInvoiceList);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titleInvoiceList,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetExpenseListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routeExpenseList);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titleExpenseList,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetOnCallListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routeOnCallList);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titleOnCallList,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddPatient() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routeAddPatient);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.add_circle_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titleAddPatient,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddExpense() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, QString.routeNewExpense);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.add_circle_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QString.titleAddExpense,
                      style: QTextStyle.homeItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
