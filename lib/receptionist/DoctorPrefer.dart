import 'dart:html';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:baby_receptionist/receptionist/DoctorPrefer.dart';

class DoctorPrefer extends StatefulWidget {
  @override
  _DoctorPreferState createState() => _DoctorPreferState();
}

class _DoctorPreferState extends State<DoctorPrefer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Doctor Prefer"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: DoctorPreferForm(),
    );
  }
}

class DoctorPreferForm extends StatefulWidget {
  @override
  _DoctorPreferFormState createState() => _DoctorPreferFormState();

}

class _DoctorPreferFormState extends State<DoctorPreferForm> {

  final DoctorPreferFormKey = GlobalKey<FormState>();
  final DateOfBirthController = TextEditingController();


  String ValueChoose;
  String DoctorSpeciality;
  List listitem = ["Cardiologist", "Ent Surgeon", "Urologist","Radiologist","Plastic Surgeon","Orthopedic Surgeon"];
  String DoctorName;
  List DoctorNamelist = ["Ahmed", "Basit", "Ali","Saad"];
  int selectedRadioTile;
  int selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.minHeight,
              ),
              child: Form(
                key: DoctorPreferFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [

                        widgetGender(),
                        widgetSelectDoctor(),
                        widgetSubmit(),

                      ],

                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget widgetGender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: DoctorSpeciality,
            titleText: 'Select Speciality',
            hintText: 'Select patient Speciality',
            onSaved: (value) {
              setState(() {
                DoctorSpeciality = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                DoctorSpeciality = value;
              });
            },
            dataSource: [
              {
                "display": "Cardiologist",
                "value": "Cardiologist",
              },
              {
                "display": "Ent Surgeon",
                "value": "Ent Surgeon",
              },
              {
                "display": "Urologist",
                "value": "Urologist",
              },
              {
                "display": "Radiologist",
                "value": "Radiologist",
              },
              {
                "display": "Plastic Surgeon",
                "value": "Plastic Surgeon",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }
  Widget widgetSelectDoctor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: DoctorName,
            titleText: 'Select Doctor',
            hintText: 'Select Doctor',
            onSaved: (value) {
              setState(() {
                DoctorName = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                DoctorName = value;
              });
            },
            dataSource: [
              {
                "display": "Ali",
                "value": "Ali",
              },
              {
                "display": "Ahmed",
                "value": "Ahmed",
              },
              {
                "display": "Hassan",
                "value": "Hassan",
              },
              {
                "display": "Zeeshan",
                "value": "Zeeshan",
              },
              {
                "display": "Ameer",
                "value": "Ameer",
              },

            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }
  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Submit'),
              onPressed: () {
                if (!DoctorPreferFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Doctor prefer successfully!')));
                DoctorPreferFormKey.currentState.save();
              },
            ),
          ),
        ),
      ],
    );
  }
}
