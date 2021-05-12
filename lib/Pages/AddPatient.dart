import 'package:baby_receptionist/Design/Dimens.dart';
import 'package:baby_receptionist/Design/Color.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:baby_receptionist/Pages/DoctorPrefer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final adPatientFormKey = GlobalKey<FormState>();
  final DateOfBirthController = TextEditingController();

  DateTime DateOfBirth;
  String ValueChoose;
  String Gender = 'Choose Gender';
  List listitem = ["Admitted", "Non Admitted"];
  int selectedRadioTile;
  int selectedRadio;
  String PatientType;
  String PatientCategory = 'Visitor';

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
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
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
                  key: adPatientFormKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Dimens.globalPaddingLeft,
                        Dimens.globalPaddingTop,
                        Dimens.globalPaddingRight,
                        Dimens.globalPaddingBottom),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        widgetPatientCategory(),
                        widgetName(),
                        widgetFatherOrHusbandName(),
                        widgetDateOfBirth(),
                        widgetGender(),
                        widgetPlaceOFBirth(),
                        widgetEmail(),
                        widgetContactNumber(),
                        widgetAddress(),
                        widgetStatus(),
                        widgetPatientType(),
                        widgetPatientExternalID(),
                        widgetBloodGroup(),
                        widgetClinicSite(),
                        widgetReferredBy(),
                        widgetReferredDate(),
                        widgetReligion(),
                        widgetParentGuardian(),
                        widgetPaymentProfile(),
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

  Widget widgetPatientCategory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 15),
      child: Card(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(2.5),
            side: BorderSide(color: Colors.grey, width: 0)),
        color: Colors.grey[100],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      ListTile(
                        title: const Text(
                          'Choose Patient Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Visitor'),
                          value: "Visitor",
                          groupValue: PatientCategory,
                          onChanged: (String value) {
                            setState(() {
                              PatientCategory = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('On Call'),
                          value: "On Call",
                          groupValue: PatientCategory,
                          onChanged: (String value) {
                            setState(() {
                              PatientCategory = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetGender() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: Gender,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                Gender = newValue;
              });
            },
            items: <String>[
              'Choose Gender',
              'Male',
              'Female',
              'Other',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget widgetName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Patient Name'),
          ),
        ),
      ],
    );
  }

  Widget widgetPlaceOFBirth() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Place of Birth'),
          ),
        ),
      ],
    );
  }

  Widget widgetFatherOrHusbandName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Father or Husband Name'),
          ),
        ),
      ],
    );
  }

  Widget widgetDateOfBirth() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: DateOfBirthController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date of Birth',
            ),
            onTap: () {
              pickDate();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetAddress() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 50,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
                labelText: 'Address'),
          ),
        ),
      ],
    );
  }

  Widget widgetEmail() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 40,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                labelText: 'Email'),
          ),
        ),
      ],
    );
  }

  Widget widgetContactNumber() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 11,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
                labelText: 'Contact Number'),
          ),
        ),
      ],
    );
  }

  Widget widgetPatientType() {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 20),
      child: Card(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(2.5),
            side: BorderSide(color: Colors.grey, width: 1)),
        color: Colors.grey[100],
        child: Column(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Patient Type : '),
                ),
                ListTile(
                  title: const Text('Panel'),
                  leading: Radio(
                    value: "Panel",
                    groupValue: PatientType,
                    onChanged: (String value) {
                      setState(() {
                        PatientType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Non-Panel'),
                  leading: Radio(
                    value: "Non-Panel",
                    groupValue: PatientType,
                    onChanged: (String value) {
                      setState(() {
                        PatientType = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetStatus() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Status (Optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetPatientExternalID() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Patient External ID (optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetBloodGroup() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Blood Group (optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetClinicSite() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.local_hospital),
                border: OutlineInputBorder(),
                labelText: 'Clinic Site (optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetReferredBy() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Referred By (optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetReferredDate() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Referred Date (optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetReligion() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Religion (optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetParentGuardian() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Parent/Guardian(optional)'),
          ),
        ),
      ],
    );
  }

  Widget widgetPaymentProfile() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.payments_outlined),
                border: OutlineInputBorder(),
                labelText: 'Payment Profile (optional)'),
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
              onPressed: () {
                if (!adPatientFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Error: Some input fields are not filled.')));
                  return;
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorPrefer()));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Patient Record successfully Added')));
                adPatientFormKey.currentState.save();
                print(DateOfBirth.toString());
              },
            ),
          ),
        ),
      ],
    );
  }

  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(DateTime.now().day + 1));
    if (date != null) {
      setState(() {
        DateOfBirth = date;
        DateOfBirthController.text = DateOfBirth.toString();
      });
    }
  }
}
