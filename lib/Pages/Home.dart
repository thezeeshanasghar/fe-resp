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

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Hi Receptionis!'),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                'Hi Receptionist!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
                leading: Icon(Icons.add_to_photos_outlined ),
                title: Text('Add Patient'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/addPatient');
                }),
            ListTile(
                leading: Icon(Icons.add_to_photos_outlined ),
                title: Text('Expense'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/Expense');
                }),
            ListTile(
                leading: Icon(Icons.add_to_photos_outlined ),
                title: Text('New Expense'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/NewExpense');
                }),
            ListTile(
                leading: Icon(Icons.add_to_photos_outlined ),
                title: Text('Patient List'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/PatientList');
                })
          ],
        ),
      ),
      body: Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
