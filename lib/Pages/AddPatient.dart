import 'dart:convert';

import 'package:baby_receptionist/Design/Dimens.dart';
import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Model/Patient.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:baby_receptionist/Service/PatientService.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final formKey = GlobalKey<FormState>();
  final DOBController = TextEditingController();
  final ReferedDateController = TextEditingController();

  String PatientType;
  DateTime DateOfBirth;
  String ValueChoose;
  String email;
  String Sex = 'Choose Gender';
  String name;
  String fatherHusbandName;
  String address;
  String city;
  String localArea;
  String dob;
  String contact;
  String cnic;
  String placeofBirth;
  String maritalStatus;
  String externalId;
  String bloodGroup;
  String clinicSite;
  String referedBy;
  String referedDate;
  String religion;
  String patientGardian;
  String paymentProfile;
  PatientService patientService;
  bool loadingButtonProgressIndicator = false;
  SimpleFontelicoProgressDialog _dialog;
  List listitem = ["Admitted", "Non Admitted"];
  int selectedRadioTile;
  int selectedRadio;

  String PatientCategory = 'Visitor';

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
    selectedRadio = 0;
    selectedRadioTile = 0;
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
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
                  key: formKey,
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
                        widgetCity(),
                        widgetLocalArea(),
                        widgetDateOfBirth(),
                        widgetGender(),
                        widgetPlaceOFBirth(),
                        widgetEmail(),
                        widgetContactNumber(),
                        widgetCNIC(),
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

  Widget widgetName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Patient Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              name = value;
            },
          ),
        ),
      ],
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
            value: Sex,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                Sex = newValue;
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

  Widget widgetFatherOrHusbandName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Father Or Husband Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              fatherHusbandName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetEmail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 40,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email'),
              validator: (String value) {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                if (!emailValid) {
                  return 'Syntax Error: email is not valid\nCorrect Syntax: babymedics@gmail.com';
                }
                return null;
              },
              onSaved: (String value) {
                email = value;
              }),
        ),
      ],
    );
  }

  Widget widgetCity() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'City'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              city = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetLocalArea() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Local Area'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              localArea = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetDateOfBirth() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: DOBController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date Of Birth',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              dob = value;
            },
            onTap: () {
              pickDateDob();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetContactNumber() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number'),
              validator: (String value) {
                int _number = int.tryParse(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                } else if (_number == null) {
                  return 'Syntax Error: Contact Number must be in numeric form\nCorrect Syntax: 03120607088';
                } else if (value.length < 11) {
                  return 'Syntax Error: A valid Contact Number must have 11 digits\nCorrect Syntax: 03120607088';
                } else if (value.substring(0, 1) != "0") {
                  return 'Syntax Error: A valid Contact Number must start with 0\nCorrect Syntax: 03120607088';
                }
                return null;
              },
              onSaved: (String value) {
                contact = value;
              }),
        ),
      ],
    );
  }

  Widget widgetPlaceOFBirth() {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Place of Birth'),
            onSaved: (String value) {
              placeofBirth = value;
            }),
      ),
    ]);
  }


  Widget widgetCNIC() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
                labelText: 'CNIC Number'),
            validator: (String value) {
              int _cnic = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              } else if (_cnic == null) {
                return 'Syntax Error: CNIC mut be in numeric form\nCorrect Syntax: 6110185363984';
              } else if (value.length > 13 || value.length < 13) {
                return 'Syntax Error: A valid CNIC must have 13 digits';
              }
              return null;
            },
            onSaved: (String value) {
              cnic = value;
            },
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
            onSaved: (String value) {
              maritalStatus = value;
            },
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
              onSaved: (String value) {
                externalId = value;
              }),
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
                onSaved: (String value) {
                bloodGroup = value;
              }),
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
                onSaved: (String value) {
                clinicSite = value;
              }),
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
                onSaved: (String value) {
                referedBy = value;
              }),
        ),
      ],
    );
  }

  Widget widgetReferredDate() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: ReferedDateController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Referred Date (Optional)',
            ),

            onSaved: (String value) {
              referedDate = value;
            },
            onTap: () {
              pickReferedDob();
            },
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
               onSaved: (String value) {
                religion = value;
              }),
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
                onSaved: (String value) {
                patientGardian = value;
              }),
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
                onSaved: (String value) {
                paymentProfile = value;
              }),
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
            padding: const EdgeInsets.fromLTRB(
                Dimens.globalInputFieldleft,
                Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight,
                Dimens.globalInputFieldBottom),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: Shade.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text('Submit'),
              onPressed: () {
                onPressedSubmitButton();
              },
            ),
          ),
        ),
      ],
    );
  }

  pickDateDob() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        dob = date.toString();
        DOBController.text = dob.toString();
      });
    }
  }
  pickReferedDob() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        referedDate = date.toString();
        ReferedDateController.text = referedDate.toString();
      });
    }
  }
  onPressedSubmitButton() async {
    // print(qualificationList);
    // print(diplomaList);
    List<dynamic> degrees = [];
    if (!formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Text('Error: Some input fields are not filled')));
      return;
    }
    setState(() {
      loadingButtonProgressIndicator = true;
    });
    formKey.currentState.save();
    _dialog.show(
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.multilines,  width: MediaQuery.of(context).size.width-50);

    Patient patient = new Patient(
        name:name,
        sex: Sex,
        fatherHusbandName: fatherHusbandName,
        email: email,
        city: city,
        localArea: localArea,
        dob: dob,
        patientDetails: "dob",
        address: "dob",
        contact: contact,
        placeofBirth: placeofBirth,
        patientCategory: PatientCategory,
        maritalStatus: maritalStatus,
        patientType: PatientType,
        externalId: externalId,
        bloodGroup: bloodGroup,
        clinicSite: clinicSite,
        referedBy: referedBy,
        referedDate: referedDate,
        religion: religion,
        patientGardian: patientGardian,
        paymentProfile: paymentProfile
    );

    var json = jsonEncode(patient.toJson());
    print(json);
      print(patient);
    var response = await patientService.InsertPatient(patient);
    print(response);
    if (response == true) {
      setState(() {
        loadingButtonProgressIndicator = false;
      });
      _dialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [
              Text('Success: Created Doctor '),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      // Navigator.pushNamed(context, Strings.routeDoctorList);
      formKey.currentState.reset();
    } else {
      _dialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to add '),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      setState(() {
        loadingButtonProgressIndicator = false;
      });
    }
  }
}
