import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PettyCashStart extends StatefulWidget {
  @override
  _PettyCashStartState createState() => _PettyCashStartState();
}

class _PettyCashStartState extends State<PettyCashStart> {
  final PettyCashStartKey = GlobalKey<FormState>();
  int TotalPettyCash;
  String EmployeeName;
  bool _isChecked = false;
  bool showDescription = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titlePettyCashStart),
        centerTitle: false,
        backgroundColor: Shade.globalAppBarColor,
        elevation: 0.0,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.minHeight,
                ),
                child: Form(
                  key: PettyCashStartKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        widgetTotalPettyCash(),
                        widgetTotalPetty(),
                        if (showDescription) widgetDescription(),
                        widgetSubmit()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetTotalPettyCash() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
                labelText: 'Total Petty Cash'),
            validator: (String value) {
              int TotalPettyCash = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              TotalPettyCash = int.tryParse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget widgetTotalPetty() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: CheckboxListTile(
            title: const Text('Report Conflict'),
            secondary: const Icon(Icons.report_problem),
            activeColor: Colors.grey[500],
            checkColor: Colors.white,
            selected: _isChecked,
            value: _isChecked,
            onChanged: (bool value) {
              _isChecked = value;
              if (_isChecked) {
                setState(() {
                  showDescription = true;
                });
              } else {
                setState(() {
                  showDescription = false;
                });
              }
            },
          ),
        )
      ],
    );
  }

  Widget widgetDescription() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Description'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              EmployeeName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: Shade.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text('Submit'),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
