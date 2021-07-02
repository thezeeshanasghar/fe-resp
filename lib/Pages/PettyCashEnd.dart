import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PettyCashEnd extends StatefulWidget {
  @override
  _PettyCashEndState createState() => _PettyCashEndState();
}

class _PettyCashEndState extends State<PettyCashEnd> {
  final PettyCashStartKey = GlobalKey<FormState>();
  int TotalPettyCash;
  int TotalCash;
  int SubmittedCash;
  String EmployeeName;
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
                        widgetTotalCash(),
                        widgetSubmittedCash(),
                        widgetPettyCash(),
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

  Widget widgetTotalCash() {
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
                labelText: 'Total Cash'),
            validator: (String value) {
              int TotalCash = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              TotalCash = int.tryParse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget widgetPettyCash() {
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
                labelText: 'Petty Cash'),
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

  Widget widgetSubmittedCash() {
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
                labelText: 'Submitted Cash'),
            validator: (String value) {
              int TotalPettyCash = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              SubmittedCash = int.tryParse(value);
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
