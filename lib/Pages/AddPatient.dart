import 'package:baby_receptionist/Common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/Common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/Common/GlobalSnakbar.dart';
import 'package:baby_receptionist/Design/Dimens.dart';
import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Requests/PatientRequest.dart';
import 'package:baby_receptionist/Model/Responses/PatientResponse.dart';
import 'package:baby_receptionist/Providers/TokenProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:baby_receptionist/Service/PatientService.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:provider/provider.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final formKey = GlobalKey<FormState>();
  final DOBController = TextEditingController();
  final JoinningDateController = TextEditingController();
  final ReferedDateController = TextEditingController();

  GlobalProgressDialog globalProgressDialog;
  String patientType;
  DateTime DateOfBirth;
  String ValueChoose;
  String email;
  String firstName;
  String lastName;
  String fatherHusbandName;
  String gender = 'Choose Gender';
  String address;
  String dob;
  String contact;
  String emergencyContact;
  String joinningDate;
  String cnic;
  int floorNo;
  String experience;
  String maritalStatus;
  String externalId;
  String bloodGroup;
  String clinicSite;
  String referedBy;
  String placeBirth;
  String referedDate;
  String religion;
  String guardian;
  String paymentProfile;
  String description;
  PatientService patientService;
  bool loadingButtonProgressIndicator = false;
  SimpleFontelicoProgressDialog _dialog;
  List listitem = ["Admitted", "Non Admitted"];
  int selectedRadioTile;
  int selectedRadio;
  bool hasChangeDependencies = false;
  String category = 'Walk In';

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
    selectedRadio = 0;
    selectedRadioTile = 0;
    _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
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
      appBar: AppBar(
        title: Text(Strings.titleAddPatient),
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
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                        Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        widgetcategory(),
                        widgetFirstName(),
                        widgetLastName(),
                        widgetFatherHusbandName(),
                        widgetGender(),
                        widgetCnic(),
                        widgetContactNumber(),
                        widgetEmergencyContactNumber(),
                        widgetEmail(),
                        widgetAddress(),
                        widgetJoinningDate(),
                        widgetDateOfBirth(),
                        widgetFloorNo(),
                        widgetExperience(),
                        widgetpatientType(),
                        widgetStatus(),
                        widgetReligion(),
                        widgetPatientExternalID(),
                        widgetBloodGroup(),
                        widgetClinicSite(),
                        widgetReferredBy(),
                        widgetReferredDate(),
                        widgetParentGuardian(),
                        widgetPaymentProfile(),
                        widgetDescription(),
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

  Widget widgetFirstName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'First Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              firstName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetLastName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Last Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              lastName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetFatherHusbandName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Father/Husband Name'),
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

  Widget widgetcategory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 15),
      child: Card(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(2.5), side: BorderSide(color: Colors.grey, width: 0)),
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
                          title: const Text('Walk In'),
                          value: "WalkIn",
                          groupValue: category,
                          onChanged: (String value) {
                            setState(() {
                              category = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('On Call'),
                          value: "OnCall",
                          groupValue: category,
                          onChanged: (String value) {
                            setState(() {
                              category = value;
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimens.globalDbffLeft, Dimens.globalDbffTop, Dimens.globalDbffRight, Dimens.globalDbffBottom),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: gender,
                elevation: 16,
                decoration: InputDecoration.collapsed(hintText: ''),
                validator: (String value) {
                  if (value == 'Choose Gender') {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                onChanged: (String newValue) {
                  setState(() {
                    gender = newValue;
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
        ),
      ],
    );
  }

  Widget widgetCnic() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card), border: OutlineInputBorder(), labelText: 'CNIC Number'),
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

  Widget widgetContactNumber() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(), labelText: 'Contact Number'),
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

  Widget widgetFloorNo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 2,
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(), labelText: 'Floor Number'),
              validator: (String value) {
                int _number = int.tryParse(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                } else if (_number == null) {
                  return 'Syntax Error: Floor Number must be in numeric form\nCorrect Syntax: 1, 2';
                }
                return null;
              },
              onSaved: (String value) {
                floorNo = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetExperience() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 2,
              autofocus: false,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(), labelText: 'Experience'),
              validator: (String value) {
                int _number = int.tryParse(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                } else if (_number == null) {
                  return 'Syntax Error: Experience must be in numeric form\nCorrect Syntax: 1, 2';
                }
                return null;
              },
              onSaved: (String value) {
                experience = value;
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
                prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Place of Birth'),
            onSaved: (String value) {
              placeBirth = value;
            }),
      ),
    ]);
  }

  Widget widgetEmergencyContactNumber() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(), labelText: 'Emergency Contact Number'),
              validator: (String value) {
                int _number = int.tryParse(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                } else if (_number == null) {
                  return 'Syntax Error:Emergency Contact Number must be in numeric form\nCorrect Syntax: 03120607088';
                } else if (value.length < 11) {
                  return 'Syntax Error: A valid Emergency Contact Number must have 11 digits\nCorrect Syntax: 03120607088';
                } else if (value.substring(0, 1) != "0") {
                  return 'Syntax Error: A valid Emergency Contact Number must start with 0\nCorrect Syntax: 03120607088';
                }
                return null;
              },
              onSaved: (String value) {
                emergencyContact = value;
              }),
        ),
      ],
    );
  }

  Widget widgetEmail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 40,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.email), border: OutlineInputBorder(), labelText: 'Email'),
              validator: (String value) {
                bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
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

  Widget widgetAddress() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Address'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              address = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetJoinningDate() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: JoinningDateController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Admitted Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              joinningDate = value;
            },
            onTap: () {
              pickDateJoinningDate();
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
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

  Widget widgetpatientType() {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 20),
      child: Card(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(2.5), side: BorderSide(color: Colors.grey, width: 1)),
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
                    groupValue: patientType,
                    onChanged: (String value) {
                      setState(() {
                        patientType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Non-Panel'),
                  leading: Radio(
                    value: "Non-Panel",
                    groupValue: patientType,
                    onChanged: (String value) {
                      setState(() {
                        patientType = value;
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
                prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Status (Optional)'),
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
                  prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Blood Group (optional)'),
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
                  prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Referred By (optional)'),
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
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
                  prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Religion (optional)'),
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
                  prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Parent/Guardian(optional)'),
              onSaved: (String value) {
                guardian = value;
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

  Widget widgetDescription() {
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
                  labelText: 'Description (optional)'),
              onSaved: (String value) {
                description = value;
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
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
        DOBController.text = dob.toString().substring(0, 10);
      });
    }
  }

  pickDateJoinningDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        joinningDate = date.toString();
        JoinningDateController.text = joinningDate.toString().substring(0, 10);
      });
    }
  }

  pickReferedDob() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        referedDate = date.toString();
        ReferedDateController.text = referedDate.toString().substring(0, 10);
      });
    }
  }

  Future<void> onPressedSubmitButton() async {
    if (!formKey.currentState.validate()) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorInputValidation, context);
      return;
    }
    formKey.currentState.save();
    try {
      globalProgressDialog.showSimpleFontellicoProgressDialog(
          false, Strings.dialogSubmitting, SimpleFontelicoProgressDialogType.multilines);
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        onCallingInsertPatient();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
      print("Upper");
    }
  }

  Future<void> onCallingInsertPatient() async {
    try {
      PatientService patientService = PatientService();
      PatientResponse patientResponse = await patientService.insertPatient(
          PatientRequest(
            id: 0,
            userId: -1,
            userType: "Patient",
            dateOfBirth: dob,
            maritalStatus: maritalStatus,
            religion: religion,
            firstName: firstName,
            lastName: lastName,
            fatherHusbandName: fatherHusbandName,
            gender: gender,
            cnic: cnic,
            contact: contact,
            emergencyContact: emergencyContact,
            email: email,
            address: address,
            joiningDate: joinningDate,
            floorNo: floorNo,
            experience: experience,
            category: category,
            birthPlace: placeBirth,
            type: patientType,
            externalId: externalId,
            bloodGroup: bloodGroup,
            clinicSite: clinicSite,
            referredBy: referedBy,
            referredDate: referedDate,
            guardian: guardian,
            paymentProfile: paymentProfile,
            description: description,
            // appointmentType: 'OnCall',
            appointmentCode: 'CODEE',
            consultationDate: referedDate,
          ),
          context.read<TokenProvider>().tokenSample.jwtToken);

      if (patientResponse != null) {
        if (patientResponse.isSuccess) {
          resetValues();
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, patientResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, patientResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  void resetValues() {
    formKey.currentState.reset();
    setState(() {
      gender = 'Choose Gender';
    });
  }
}
