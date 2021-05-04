
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Patient"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: AddPatientForm(),
    );
  }
}

class AddPatientForm extends StatefulWidget {
  @override
  _AddPatientFormState createState() => _AddPatientFormState();



}
enum BestTutorSite { javatpoint, w3schools, tutorialandexample }
class _AddPatientFormState extends State<AddPatientForm> {

  final adPatientFormKey = GlobalKey<FormState>();
  final DateOfBirthController = TextEditingController();

   DateTime DateOfBirth;
   String ValueChoose;
   String Gender;
  List listitem = ["Admitted", "Non Admitted"];
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
                key: adPatientFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [
                        widgetName(),
                        widgetFatherOrHusbandName(),
                        widgetDateOfBirth(),
                        widgetGender(),
                        widgetPlaceOFBirth(),
                        widgetEmail(),
                        widgetContactNumber(),
                        widgetAddress(),
                        widgetStatus(),
                        widgetPanelNonPanel(),
                        widgetPatientExternalID(),
                        widgetBloodGroup(),
                        widgetClinicSite(),
                        widgetReferredBy(),
                        widgetReferredDate(),
                        widgetReligion(),
                        widgetParentGuardian(),
                        widgetPaymentProfile(),
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
            value: Gender,
            titleText: 'Gender',
            hintText: 'Select your Gender',
            onSaved: (value) {
              setState(() {
                Gender = value;
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
                Gender = value;
              });
            },
            dataSource: [
              {
                "display": "Male",
                "value": "Male",
              },
              {
                "display": "Female",
                "value": "Female",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
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
              icon: Icon(Icons.date_range),
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
                  icon: Icon(Icons.home),
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
                  icon: Icon(Icons.email),
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
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number'),
              ),
        ),
      ],
    );
  }
  Widget widgetPanelNonPanel(){
    return Column(
     children:<Widget>[
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),

    child: RadioListTile(
        value: 1,
        groupValue: selectedRadioTile,
         selectedTileColor: Colors.grey[750],
        title: Text("Panel"),
        onChanged: (val) {
          setSelectedRadioTile(val);
        },
        activeColor: Colors.grey[750],
        selected: true,
      ),
    ),
       Padding(
         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
         child: RadioListTile(
           value: 2,
           groupValue: selectedRadioTile,
           selectedTileColor: Colors.grey[750],
           title: Text("Non Panel"),

           onChanged: (val) {
             setSelectedRadioTile(val);
           },
           activeColor: Colors.grey[750],
           selected: true,
         ),
       ),
    ],
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.local_hospital),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Parent/Guardian(optional)'),
          ),
        ),
      ],
    );
  }
  Widget  widgetPaymentProfile() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                icon: Icon(Icons.payments_outlined),
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
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Add Patient'),
              onPressed: () {
                if (!adPatientFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorPrefer()
                ));
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Patient Record successfully Added')));
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
        lastDate: DateTime(DateTime.now().day+1));
    if (date != null) {
      setState(() {
        DateOfBirth = date;
        DateOfBirthController.text = DateOfBirth.toString();
      });
    }
  }


}
