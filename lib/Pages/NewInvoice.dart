import 'dart:convert';

import 'package:baby_receptionist/Arguments/PatientArguments.dart';
import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Appointment.dart';
import 'package:baby_receptionist/Model/Doctor.dart';
import 'package:baby_receptionist/Model/Invoice.dart';
import 'package:baby_receptionist/Model/PatientInvoice.dart';
import 'package:baby_receptionist/Service/DoctorService.dart';
import 'package:baby_receptionist/Service/InvoiceService.dart';
import 'package:baby_receptionist/Service/PatientService.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class NewInvoice extends StatefulWidget {
  @override
  _NewInvoiceState createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  final formKey = GlobalKey<FormState>();
  final lastVisitDateController = TextEditingController();
  final TodayVisitDateController = TextEditingController();
  final DateOfBirthController = TextEditingController();
  String PreviousVisitDate;
  String TodayVisit;
  String DateThree;
  String Invoices = "Select Invoice";
  String Name;
  String FatherName;
  String Email;
  String ContactNumber;
  String City = "Select City";
  String CityDetail = "Select City Detail";
  String Block;
  String DoctorName = 'Select Doctor';
  String DoctorType = 'Select Doctor Type';
  int ConsultationFee;
  String PaymentType = "Select Payment Type";
  String ProcedureType = "Select Procedure Type";
  int Total;
  int Discount;
  int NetTotal;
  int Disposable;
  int GrossTotal;
  PatientService patientService;
  DoctorService doctorService;
  InvoiceService invoiceService = InvoiceService();
  bool isLoading = false;
  SimpleFontelicoProgressDialog _dialog;
  TextEditingController _namecontroller;
  TextEditingController _fatherhusbandnamecontroller;
  bool loadingButtonProgressIndicator = false;
  TextEditingController _citycontroller;
  TextEditingController _LocalAreacontroller;
  TextEditingController _emailcontroller;
  TextEditingController _contactcontroller;
  bool hasRun = false;
  PatientArguments args;
  int PatientId;
  List<DoctorData> listDoctors;
  String Patient;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();

    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (!hasRun) {
      args = ModalRoute.of(context).settings.arguments;
      PatientId = args.Id;
      getPatientData(PatientId);
      getDoctorsData();
      hasRun = true;
    }
  }
  void getDoctorsData() async {
  doctorService =DoctorService();
  var listAdmitted = [];
  Doctor resp=await doctorService.getDoctor();
  listDoctors=resp.data;
  setState(() {
    print(resp.data[0].employee.emergencyContact);
    print("ANEES");
  });
  }

  void getPatientData(int Id) async {
    // patientService = PatientService();
    // PatientSingleInvoice resp = await patientService.getPatientInvoiceById(Id);
    // setState(() {
    //   print(resp.data.toJson());
    //   _namecontroller.text = resp.data.name;
    //   _fatherhusbandnamecontroller.text = resp.data.fatherHusbandName;
    //   DateOfBirthController.text = resp.data.dob.substring(0, 10);
    //   lastVisitDateController.text =
    //       resp.data.lastAppointmentDate.substring(0, 10);
    //   TodayVisitDateController.text =
    //       DateTime.now().toString().substring(0, 10);
    //   _citycontroller.text = resp.data.city;
    //   _LocalAreacontroller.text = resp.data.area;
    //   _emailcontroller.text = resp.data.email;
    //   _contactcontroller.text = resp.data.contact;
    // });
  }

  void initVariablesAndClasses() {
    _namecontroller = new TextEditingController();
    _fatherhusbandnamecontroller = new TextEditingController();
    _citycontroller = new TextEditingController();
    _LocalAreacontroller = new TextEditingController();
    _emailcontroller = new TextEditingController();
    _contactcontroller = new TextEditingController();
    patientService = PatientService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleAddInvoice),
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
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widgetRowOne(),
                          widgetRowTwo(),
                          widgetDateThree(),
                          widgetRowFour(),
                          widgetRowFive(),
                          widgetBlockName(),
                          widgetRowSeven(),
                          widgetRowEight(),
                          widgetTotal(),
                          widgetDiscount(),
                          widgetNetTotal(),
                          widgetDisposable(),
                          widgetGrossTotal(),
                          widgetSubmit(),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetGrossTotal() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'GrossTotal (rupees)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                GrossTotal = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetDisposable() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Disposable (rupees)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                Disposable = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetNetTotal() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Net Total (rupees)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                NetTotal = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetDiscount() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Discount (rupees)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                Discount = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetTotal() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Total (rupees)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                Total = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetRowEight() {
    return Row(
      children: [
        Expanded(child: widgetConsultationFee()),
        Expanded(child: widgetPaymentType()),
        Expanded(child: widgetProcedureType()),
      ],
    );
  }

  Widget widgetProcedureType() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: ProcedureType,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                ProcedureType = newValue;
              });
            },
            items: <String>['Select Procedure Type', 'Procedure', 'Medicine']
                .map<DropdownMenuItem<String>>((String value) {
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

  Widget widgetPaymentType() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: PaymentType,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                PaymentType = newValue;
              });
            },
            items: <String>[
              'Select Payment Type',
              'Cash',
              'Credit Card',
              'Easypaisa'
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

  Widget widgetConsultationFee() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Consultation Fee'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                ConsultationFee = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetRowSeven() {
    return Row(
      children: [
        Expanded(child: widgetDoctorName()),
        Expanded(child: widgetDoctorType()),
      ],
    );
  }

  Widget widgetDoctorName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: DoctorName,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                DoctorName = newValue;
              });
            },
            items: <String>[
              'Select Doctor',
              'Dr. Salman',
              'Dr. Amna',
              'Dr. Ali'
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

  Widget widgetDoctorType() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: DoctorType,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                DoctorType = newValue;
              });
            },
            items: <String>[
              'Select Doctor Type',
              'Pediatrician',
              'Psychiatrist',
              'Dermatologist'
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

  Widget widgetRowFive() {
    return Row(
      children: [
        Expanded(child: widgetCity()),
        Expanded(child: widgetCityDetail()),
      ],
    );
  }

  Widget widgetCityDetail() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              readOnly: true,
              controller: _LocalAreacontroller,
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
                CityDetail = value;
              }),
        ),
      ],
    );
  }

  Widget widgetCity() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              readOnly: true,
              controller: _citycontroller,
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
                City = value;
              }),
        ),
      ],
    );
  }

  Widget widgetRowFour() {
    return Row(
      children: [
        Expanded(child: widgetEmail()),
        Expanded(child: widgetContactNumber()),
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
              readOnly: true,
              controller: _contactcontroller,
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
                ContactNumber = value;
              }),
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
              maxLength: 40,
              autofocus: false,
              readOnly: true,
              controller: _emailcontroller,
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
                Email = value;
              }),
        ),
      ],
    );
  }

  Widget widgetRowTwo() {
    return Row(
      children: [
        Expanded(child: widgetChildName()),
        Expanded(child: widgetFatherName()),
      ],
    );
  }

  Widget widgetChildName() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              autofocus: false,
              readOnly: true,
              controller: _namecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                Name = value;
              },
            )),
      ],
    );
  }

  Widget widgetBlockName() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.roofing),
                  border: OutlineInputBorder(),
                  labelText: 'Block'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                Block = value;
              },
            )),
      ],
    );
  }

  Widget widgetFatherName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              readOnly: true,
              controller: _fatherhusbandnamecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Father Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                FatherName = value;
              }),
        ),
      ],
    );
  }

  Widget widgetRowOne() {
    return Row(
      children: [
        Expanded(child: widgetDateOne()),
        Expanded(child: widgetDateTwo()),
        Expanded(child: widgetInvoice()),
      ],
    );
  }

  Widget widgetDateOne() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: lastVisitDateController,
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Previous Visit Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              PreviousVisitDate = value;
            },
            onTap: () {
              pickDateOne();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetDateTwo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: TodayVisitDateController,
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Today Visit Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              TodayVisit = value;
            },
            onTap: () {
              pickDateTwo();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetDateThree() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            enabled: false,
            controller: DateOfBirthController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date of Birth',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              DateThree = value;
            },
            onTap: () {
              pickDateThree();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetInvoice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: Invoices,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                Invoices = newValue;
              });
            },
            items: <String>[
              'Select Invoice',
              'Invoice 1',
              'Invoice 2',
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

  pickDateOne() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        PreviousVisitDate = date.toString();
        lastVisitDateController.text = date.toString();
      });
    }
  }

  pickDateTwo() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        TodayVisit = date.toString();
        TodayVisitDateController.text = date.toString().substring(0, 10);
      });
    }
  }

  pickDateThree() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        DateThree = date.toString();
        DateOfBirthController.text = date.toString();
      });
    }
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
                onPressedSubmitButton();
              },
            ),
          ),
        ),
      ],
    );
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
        type: SimpleFontelicoProgressDialogType.multilines,
        width: MediaQuery.of(context).size.width - 50);

    InvoiceData invoiceData = new InvoiceData(
      PaymentType: PaymentType,
      PreviousVisitDate: PreviousVisitDate,
      TodayVisitDate: TodayVisit,
      ConsultationFee: ConsultationFee,
      NetAmount: NetTotal,
      Disposibles: Disposable,
      GrossAmount: GrossTotal,
      IsRefund: 0,
      RefundAmount: 0,
      Discount: Discount,
    );
    var response = await invoiceService.InsertInvoice(invoiceData);
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
              Text('Success: Created Invoice '),
              Text(
                Name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      formKey.currentState.reset();

      // Navigator.pushNamed(context, Strings.routeNurseList);
    } else {
      _dialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to add '),
              Text(
                Name,
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
