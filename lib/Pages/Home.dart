import 'package:baby_receptionist/Design/Dimens.dart';
import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Pages/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Shade.globalBackgroundColor,
        appBar: AppBar(
          title: Text(Strings.titleHomePage),
          backgroundColor: Shade.globalAppBarColor,
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
                      backgroundImage: AssetImage('assets/joker.jpg'),
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
                title: Text(Strings.titleAddPatient),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeAddPatient);
                },
              ),
              ListTile(
                  leading: Icon(Icons.list_alt_outlined),
                  title: Text(Strings.titlePatientList),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routePatientList);
                  }),
              ListTile(
                leading: Icon(Icons.fiber_new_outlined),
                title: Text(Strings.titleAddExpense),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeNewExpense);
                },
              ),
              ListTile(
                  leading: Icon(Icons.line_style_outlined),
                  title: Text(Strings.titleExpenseList),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routeExpenseList);
                  }),
              ListTile(
                  leading: Icon(Icons.contact_phone_outlined),
                  title: Text(Strings.titleOnCallList),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routeOnCallList);
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
                            Dimens.globalPaddingLeft,
                            Dimens.globalPaddingTop,
                            Dimens.globalPaddingRight,
                            Dimens.globalPaddingBottom),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              widgetRowHeaderOne(),
                              widgetRowOne(),
                              widgetRowHeaderTwo(),
                              widgetRowThree(),
                              widgetRowHeaderThere(),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
  Widget widgetRowHeaderThere() {
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
                            'Receptionist Start and End Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
        widgetExpenseListCard(),
        widgetOnCallListCard(),

      ],
    );
  }
  Widget widgetRowFour() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetStartTimer(),
        widgetDummySpaceCard(),
        widgetDummySpaceCard(),

      ],
    );
  }

  Widget widgetDummySpaceCard() {
    return Expanded(
      child: Text(
        'Click to create the account of a doctor',
        style: TextStyle(color: Shade.globalBackgroundColor),
      ),
    );
  }
  Widget widgetPatientListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routePatientList);
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
                      Strings.titlePatientList,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to view the list of patients',
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
          Navigator.pushNamed(context, Strings.routeExpenseList);
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
                      Strings.titleExpenseList,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to view the list of expense',
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
          Navigator.pushNamed(context, Strings.routeOnCallList);
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
                      Strings.titleOnCallList,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to view the list of On Call Patients',
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
          Navigator.pushNamed(context, Strings.routeAddPatient);
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
                      Strings.titleAddPatient,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to add Patient',
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
          Navigator.pushNamed(context, Strings.routeNewExpense);
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
                      Strings.titleAddExpense,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create the room of a hospital',
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
  Widget widgetStartTimer() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeShift);
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
                      Strings.titleShift,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to Start and ent the shift',
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
