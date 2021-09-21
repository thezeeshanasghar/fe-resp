import 'package:baby_receptionist/data/models/Sample/PatientSample.dart';
import 'package:baby_receptionist/data/service/PatientService.dart';
import 'package:baby_receptionist/presentation/Pages/NewInvoice.dart';
import 'package:baby_receptionist/presentation/Pages/Refund.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  bool admitted = false;
  bool walkIn = true;
  bool online = false;

  final formKey = GlobalKey<FormState>();

  // walkIn Data
  List<DatatableHeader> walkInHeaders = [];
  List<int> walkInPerPage = [5, 10, 15, 100];
  int walkInTotal = 100;
  int walkInCurrentPerPage;
  int walkInCurrentPage = 1;
  bool walkInIsSearch;
  List<Map<String, dynamic>> walkInIsSource = [];
  List<Map<String, dynamic>> walkInSelecteds = [];
  String walkInSelectableKey = "Invoice";
  String walkInSortColumn;
  bool walkInSortAscending = true;
  bool walkInIsLoading = true;
  bool walkInShowSelect = false;

  // PatientInvoice listWalkIns;
  PatientService patientService;
  String dropdownDoctor = "Select Doctor";
  String dropdownDate = "Select Date";
  String dropdownBookedBy = "Select Booked By";

  // Online Data
  List<DatatableHeader> onlineHeaders = [];
  List<int> onlinePerPage = [5, 10, 15, 100];
  int onlineTotal = 100;
  int onlineCurrentPerPage;
  int onlineCurrentPage = 1;
  bool onlineIsSearch = false;
  List<Map<String, dynamic>> onlineIsSource = [];
  List<Map<String, dynamic>> onlineSelecteds = [];
  String onlineSelectableKey = "Invoice";
  String onlineSortColumn;
  String PatientId;
  bool onlineSortAscending = true;
  bool onlineIsLoading = true;
  bool onlineShowSelect = false;

  // PatientInvoice listOnlines;

  // Admitted Data
  List<DatatableHeader> admittedHeaders = [];
  List<int> admittedPerPage = [5, 10, 15, 100];
  int admittedTotal = 100;
  int admittedCurrentPerPage;
  int admittedCurrentPage = 1;
  bool admittedIsSearch = false;
  List<Map<String, dynamic>> admittedIsSource = [];
  List<Map<String, dynamic>> admittedSelecteds = [];
  String admittedSelectableKey = "Invoice";
  String admittedSortColumn;
  bool admittedSortAscending = true;
  bool admittedIsLoading = true;
  bool admittedShowSelect = false;

  // admitted
  void initAdmittedVariablesAndClasses() {
    admittedHeaders = [];
    admittedPerPage = [5, 10, 15, 100];
    admittedTotal = 100;
    admittedCurrentPage = 1;
    admittedIsSearch = false;
    admittedIsSource = [];
    admittedSelecteds = [];
    admittedSelectableKey = "Invoice";
    admittedSortAscending = true;
    admittedIsLoading = true;
    admittedShowSelect = false;

    patientService = PatientService();
  }

  void gettAdmittedFromApiAndLinkToTable() async {
    setState(() => admittedIsLoading = true);
    admittedIsSource = [];
    var listAdmitted = [];
    // PatientInvoice patientResponse = await patientService.getPatientInvoice('admitted');
    // listAdmitted = patientResponse.data;
    // admittedIsSource.addAll(generateOnlineDataFromApi(listAdmitted));
    setState(() => admittedIsLoading = false);
  }

  initializeAdmittedHeaders() {
    admittedHeaders = [
      DatatableHeader(
          value: "Date",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "PatientName",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Patient Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FatherName",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Father Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "DOB",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "DOB",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "CheckupType",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Checkup Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "BookingNo",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Booking No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Action",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          sourceBuilder: (value, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewInvoice()),
                      );
                    },
                    child: Text('New Invoice')),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Refund()),
                      );
                    },
                    child: Text(
                      'Refund',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
          }),
    ];
  }

  List<Map<String, dynamic>> generateadmittedDataFromApi(List<PatientSample> listAdmitted) {
    List<Map<String, dynamic>> tempswalkIn = [];
    // for (PatientInvoiceData patients in listAdmitted) {
    //   tempswalkIn.add({
    //     "Invoice": patients.id,
    //     "Name": patients.name,
    //     "FatherName": patients.fatherHusbandName,
    //     "Total": patients.netAmount - patients.discount,
    //     "Discount": patients.discount,
    //     "NetTotal": patients.netAmount,
    //     "Action": patients.patientId,
    //   });
    // }
    return tempswalkIn;
  }

  // Walkin
  initializeWalkInHeaders() {
    walkInHeaders = [
      DatatableHeader(
          value: "Invoice",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Invoice",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Date",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FatherName",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Father Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "DOB",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "DOB",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Total",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Discount",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Discount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "NetTotal",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Net Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Refund",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Refund",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 3,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "New Invoice",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          sourceBuilder: (Id, row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      print(Id);
                      Navigator.pushNamed(
                        context,
                        QString.routeNewInvoice,
                      );
                    },
                    child: Text('New Invoice')),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Refund()),
                      // );
                    },
                    child: Text(
                      'Admit',
                      style: TextStyle(color: Colors.green),
                    )),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Refund()),
                      );
                    },
                    child: Text(
                      'Refund',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            );
          }),
    ];
  }

  void initWalkInVariablesAndClasses() {
    walkInHeaders = [];
    walkInPerPage = [5, 10, 15, 100];
    walkInTotal = 100;
    walkInCurrentPerPage;
    walkInCurrentPage = 1;
    walkInIsSearch = false;
    walkInIsSource = [];
    walkInSelecteds = [];
    walkInSelectableKey = "Invoice";
    walkInSortColumn;
    walkInSortAscending = true;
    walkInIsLoading = true;
    walkInShowSelect = false;

    patientService = PatientService();
  }

  void getWalkInFromApiAndLinkToTable() async {
    setState(() => walkInIsLoading = true);
    walkInIsSource = [];
    var listWalkIns = [];
    // PatientInvoice patientResponse = await patientService.getPatientInvoice('walkin');
    // listWalkIns = patientResponse.data;
    // walkInIsSource.addAll(generatewalkInDataFromApi(listWalkIns));
    setState(() => walkInIsLoading = false);
  }

  List<Map<String, dynamic>> generatewalkInDataFromApi(List<PatientSample> listWalkIns) {
    List<Map<String, dynamic>> tempswalkIn = [];
    // for (PatientInvoiceData patients in listWalkIns) {
    //   tempswalkIn.add({
    //     "Invoice": patients.id,
    //     "Name": patients.name,
    //     "FatherName": patients.fatherHusbandName,
    //     "Total": patients.netAmount - patients.discount,
    //     "Discount": patients.discount,
    //     "NetTotal": patients.netAmount,
    //     "Action": patients.patientId,
    //   });
    // }
    return tempswalkIn;
  }

  // Oncall
  void initOnlineVariablesAndClasses() {
    onlineHeaders = [];
    onlinePerPage = [5, 10, 15, 100];
    onlineTotal = 100;
    onlineCurrentPerPage;
    onlineCurrentPage = 1;
    onlineIsSearch = false;
    onlineIsSource = [];
    onlineSelecteds = [];
    onlineSelectableKey = "Invoice";
    onlineSortColumn;
    onlineSortAscending = true;
    onlineIsLoading = true;
    onlineShowSelect = false;

    patientService = PatientService();
  }

  void getOnlineFromApiAndLinkToTable() async {
    setState(() => onlineIsLoading = true);
    onlineIsSource = [];
    var listOnlines = [];
    // PatientInvoice patientResponse = await patientService.getPatientInvoice('Online');
    // listOnlines = patientResponse.data;
    // onlineIsSource.addAll(generateOnlineDataFromApi(listOnlines));
    setState(() => onlineIsLoading = false);
  }

  initializeOnlineHeaders() {
    onlineHeaders = [
      DatatableHeader(
          value: "Invoice",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Invoice",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "PatientName",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Patient Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FatherName",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Father Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "DOB",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "DOB",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "CheckupType",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Checkup Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "BookingNo",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Booking No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Action",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          sourceBuilder: (Id, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      print(Id);
                      Navigator.pushNamed(
                        context,
                        QString.routeNewInvoice,
                      );
                    },
                    child: Text('New Invoice')),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Refund()),
                      );
                    },
                    child: Text(
                      'Refund',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
          }),
    ];
  }

  List<Map<String, dynamic>> generateOnlineDataFromApi(List<PatientSample> listOnlines) {
    List<Map<String, dynamic>> tempsOnline = [];
    // for (PatientInvoiceData patients in listOnlines) {
    //   tempsOnline.add({
    //     "Invoice": patients.id,
    //     "PatientName": patients.name,
    //     "FatherName": patients.fatherHusbandName,
    //     "DOB": patients.dob.substring(0, 10),
    //     "Contact": patients.contact,
    //     "CheckupType": patients.category,
    //     "Total": patients.netAmount - patients.discount,
    //     "Discount": patients.discount,
    //     "NetTotal": patients.netAmount,
    //     "Action": patients.patientId,
    //   });
    // }
    return tempsOnline;
  }

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
    // walk in
    initWalkInVariablesAndClasses();
    initializeWalkInHeaders();
    getWalkInFromApiAndLinkToTable();

    // online
    initOnlineVariablesAndClasses();
    initializeOnlineHeaders();
    getOnlineFromApiAndLinkToTable();

    // admitted
    initializeAdmittedHeaders();
    initializeAdmittedHeaders();
    gettAdmittedFromApiAndLinkToTable();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(QString.titlePatientList),
        centerTitle: false,
        backgroundColor: QColor.globalAppBarColor,
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
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widgetTableType(),
                          SizedBox(
                            height: 20,
                          ),
                          if (walkIn) widgetWalkInPatients(),
                          if (online) widgetOnlinePatients(),
                          if (admitted) widgetAdmittedPatients(),
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

  String TableType = 'Walk-in Patients';

  Widget widgetTableType() {
    return Card(
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
                        'Choose Patients Table',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Walk-in Patients'),
                        value: "Walk-in Patients",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            walkIn = true;
                            admitted = false;
                            online = false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Online'),
                        value: "Online",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            walkIn = false;
                            admitted = false;
                            online = true;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Admitted'),
                        value: "Admitted",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            walkIn = false;
                            admitted = true;
                            online = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetWalkInPatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Container(
            color: Colors.grey[50],
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Column(
                      //   children: [
                      //     Text(
                      //       'Doctor',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[300])),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownDoctor,
                              elevation: 16,
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownDoctor = newValue;
                                });
                              },
                              items: <String>['Select Doctor', 'Dr. Salman', 'Dr. Faisal', 'Dr. Nawaz', 'Dr. Sadia']
                                  .map<DropdownMenuItem<String>>((String value) {
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
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Column(
                      //   children: [
                      //     Text(
                      //       'Date',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[300])),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownDate,
                              elevation: 16,
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownDate = newValue;
                                });
                              },
                              items: <String>[
                                'Select Date',
                                'All',
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
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Column(
                      //   children: [
                      //     Text(
                      //       'Booked By',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[300])),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownBookedBy,
                              elevation: 16,
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownBookedBy = newValue;
                                });
                              },
                              items: <String>[
                                'Select Booked By',
                                'All',
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
                  ),
                )),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveDatatable(
              title: !walkInIsSearch
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.directions_walk_sharp),
                        ),
                        Text(
                          'Walk-in (Out Patients)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : null,
              actions: [
                if (walkInIsSearch)
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                walkInIsSearch = false;
                              });
                            }),
                        suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
                  )),
                if (!walkInIsSearch)
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          walkInIsSearch = true;
                        });
                      })
              ],
              headers: walkInHeaders,
              source: walkInIsSource,
              selecteds: walkInSelecteds,
              showSelect: walkInShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                // print(data);
              },
              onSort: (value) {
                setState(() {
                  walkInSortColumn = value;
                  walkInSortAscending = !walkInSortAscending;
                  if (walkInSortAscending) {
                    walkInIsSource.sort((a, b) => b["$walkInSortColumn"].compareTo(a["$walkInSortColumn"]));
                  } else {
                    walkInIsSource.sort((a, b) => a["$walkInSortColumn"].compareTo(b["$walkInSortColumn"]));
                  }
                });
              },
              sortAscending: walkInSortAscending,
              sortColumn: walkInSortColumn,
              isLoading: walkInIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => walkInSelecteds.add(item));
                } else {
                  setState(() => walkInSelecteds.removeAt(walkInSelecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => walkInSelecteds = walkInIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => walkInSelecteds.clear());
                }
              },
              footers: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Rows per page:"),
                ),
                if (walkInPerPage != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton(
                        value: walkInCurrentPerPage,
                        items: walkInPerPage
                            .map((e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            walkInCurrentPerPage = value;
                          });
                        }),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("$walkInCurrentPage - $walkInCurrentPerPage of $walkInTotal"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      walkInCurrentPage = walkInCurrentPage >= 2 ? walkInCurrentPage - 1 : 1;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    setState(() {
                      walkInCurrentPage++;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget widgetOnlinePatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        //   child: Container(
        //     color: Colors.grey[50],
        //     child: Row(
        //       children: [
        //         Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Column(
        //                   //   children: [
        //                   //     Text(
        //                   //       'Doctor',
        //                   //       style: TextStyle(fontWeight: FontWeight.bold),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(5),
        //                           border: Border.all(color: Colors.grey[300])),
        //                       child: Padding(
        //                         padding:
        //                         const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                         child: DropdownButton<String>(
        //                           isExpanded: true,
        //                           value: dropdownDoctor,
        //                           elevation: 16,
        //                           underline: Container(
        //                             height: 0,
        //                             color: Colors.deepPurpleAccent,
        //                           ),
        //                           onChanged: (String newValue) {
        //                             setState(() {
        //                               dropdownDoctor = newValue;
        //                             });
        //                           },
        //                           items: <String>[
        //                             'Select Doctor',
        //                             'Dr. Salman',
        //                             'Dr. Faisal',
        //                             'Dr. Nawaz',
        //                             'Dr. Sadia'
        //                           ].map<DropdownMenuItem<String>>(
        //                                   (String value) {
        //                                 return DropdownMenuItem<String>(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               }).toList(),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //         Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Column(
        //                   //   children: [
        //                   //     Text(
        //                   //       'Date',
        //                   //       style: TextStyle(fontWeight: FontWeight.bold),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(5),
        //                           border: Border.all(color: Colors.grey[300])),
        //                       child: Padding(
        //                         padding:
        //                         const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                         child: DropdownButton<String>(
        //                           isExpanded: true,
        //                           value: dropdownDate,
        //                           elevation: 16,
        //                           underline: Container(
        //                             height: 0,
        //                             color: Colors.deepPurpleAccent,
        //                           ),
        //                           onChanged: (String newValue) {
        //                             setState(() {
        //                               dropdownDate = newValue;
        //                             });
        //                           },
        //                           items: <String>[
        //                             'Select Date',
        //                             'All',
        //                           ].map<DropdownMenuItem<String>>(
        //                                   (String value) {
        //                                 return DropdownMenuItem<String>(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               }).toList(),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //         Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Column(
        //                   //   children: [
        //                   //     Text(
        //                   //       'Booked By',
        //                   //       style: TextStyle(fontWeight: FontWeight.bold),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(5),
        //                           border: Border.all(color: Colors.grey[300])),
        //                       child: Padding(
        //                         padding:
        //                         const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                         child: DropdownButton<String>(
        //                           isExpanded: true,
        //                           value: dropdownBookedBy,
        //                           elevation: 16,
        //                           underline: Container(
        //                             height: 0,
        //                             color: Colors.deepPurpleAccent,
        //                           ),
        //                           onChanged: (String newValue) {
        //                             setState(() {
        //                               dropdownBookedBy = newValue;
        //                             });
        //                           },
        //                           items: <String>[
        //                             'Select Booked By',
        //                             'All',
        //                           ].map<DropdownMenuItem<String>>(
        //                                   (String value) {
        //                                 return DropdownMenuItem<String>(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               }).toList(),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveDatatable(
              title: !onlineIsSearch
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.online_prediction),
                        ),
                        Text(
                          "Online",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : null,
              actions: [
                if (onlineIsSearch)
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                onlineIsSearch = false;
                              });
                            }),
                        suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
                  )),
                if (!onlineIsSearch)
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          onlineIsSearch = true;
                        });
                      })
              ],
              headers: onlineHeaders,
              source: onlineIsSource,
              selecteds: onlineSelecteds,
              showSelect: onlineShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                // print(data);
              },
              onSort: (value) {
                setState(() {
                  onlineSortColumn = value;
                  onlineSortAscending = !onlineSortAscending;
                  if (onlineSortAscending) {
                    onlineIsSource.sort((a, b) => b["$onlineSortColumn"].compareTo(a["$onlineSortColumn"]));
                  } else {
                    onlineIsSource.sort((a, b) => a["$onlineSortColumn"].compareTo(b["$onlineSortColumn"]));
                  }
                });
              },
              sortAscending: onlineSortAscending,
              sortColumn: onlineSortColumn,
              isLoading: onlineIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => onlineSelecteds.add(item));
                } else {
                  setState(() => onlineSelecteds.removeAt(onlineSelecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => onlineSelecteds = onlineIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => onlineSelecteds.clear());
                }
              },
              footers: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Rows per page:"),
                ),
                if (onlinePerPage != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton(
                        value: onlineCurrentPerPage,
                        items: onlinePerPage
                            .map((e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            onlineCurrentPerPage = value;
                          });
                        }),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("$onlineCurrentPage - $onlineCurrentPerPage of $onlineTotal"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      onlineCurrentPage = onlineCurrentPage >= 2 ? onlineCurrentPage - 1 : 1;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    setState(() {
                      onlineCurrentPage++;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget widgetAdmittedPatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        //   child: Container(
        //     color: Colors.grey[50],
        //     child: Row(
        //       children: [
        //         Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Column(
        //                   //   children: [
        //                   //     Text(
        //                   //       'Doctor',
        //                   //       style: TextStyle(fontWeight: FontWeight.bold),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(5),
        //                           border: Border.all(color: Colors.grey[300])),
        //                       child: Padding(
        //                         padding:
        //                         const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                         child: DropdownButton<String>(
        //                           isExpanded: true,
        //                           value: dropdownDoctor,
        //                           elevation: 16,
        //                           underline: Container(
        //                             height: 0,
        //                             color: Colors.deepPurpleAccent,
        //                           ),
        //                           onChanged: (String newValue) {
        //                             setState(() {
        //                               dropdownDoctor = newValue;
        //                             });
        //                           },
        //                           items: <String>[
        //                             'Select Doctor',
        //                             'Dr. Salman',
        //                             'Dr. Faisal',
        //                             'Dr. Nawaz',
        //                             'Dr. Sadia'
        //                           ].map<DropdownMenuItem<String>>(
        //                                   (String value) {
        //                                 return DropdownMenuItem<String>(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               }).toList(),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //         Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Column(
        //                   //   children: [
        //                   //     Text(
        //                   //       'Date',
        //                   //       style: TextStyle(fontWeight: FontWeight.bold),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(5),
        //                           border: Border.all(color: Colors.grey[300])),
        //                       child: Padding(
        //                         padding:
        //                         const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                         child: DropdownButton<String>(
        //                           isExpanded: true,
        //                           value: dropdownDate,
        //                           elevation: 16,
        //                           underline: Container(
        //                             height: 0,
        //                             color: Colors.deepPurpleAccent,
        //                           ),
        //                           onChanged: (String newValue) {
        //                             setState(() {
        //                               dropdownDate = newValue;
        //                             });
        //                           },
        //                           items: <String>[
        //                             'Select Date',
        //                             'All',
        //                           ].map<DropdownMenuItem<String>>(
        //                                   (String value) {
        //                                 return DropdownMenuItem<String>(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               }).toList(),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //         Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Column(
        //                   //   children: [
        //                   //     Text(
        //                   //       'Booked By',
        //                   //       style: TextStyle(fontWeight: FontWeight.bold),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(5),
        //                           border: Border.all(color: Colors.grey[300])),
        //                       child: Padding(
        //                         padding:
        //                         const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                         child: DropdownButton<String>(
        //                           isExpanded: true,
        //                           value: dropdownBookedBy,
        //                           elevation: 16,
        //                           underline: Container(
        //                             height: 0,
        //                             color: Colors.deepPurpleAccent,
        //                           ),
        //                           onChanged: (String newValue) {
        //                             setState(() {
        //                               dropdownBookedBy = newValue;
        //                             });
        //                           },
        //                           items: <String>[
        //                             'Select Booked By',
        //                             'All',
        //                           ].map<DropdownMenuItem<String>>(
        //                                   (String value) {
        //                                 return DropdownMenuItem<String>(
        //                                   value: value,
        //                                   child: Text(value),
        //                                 );
        //                               }).toList(),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveDatatable(
              title: !admittedIsSearch
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.king_bed),
                        ),
                        Text(
                          "Admitted",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : null,
              actions: [
                if (admittedIsSearch)
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                onlineIsSearch = false;
                              });
                            }),
                        suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
                  )),
                if (!admittedIsSearch)
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          admittedIsSearch = true;
                        });
                      })
              ],
              headers: admittedHeaders,
              source: admittedIsSource,
              selecteds: admittedSelecteds,
              showSelect: admittedShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                // print(data);
              },
              onSort: (value) {
                setState(() {
                  admittedSortColumn = value;
                  admittedSortAscending = !admittedSortAscending;
                  if (admittedSortAscending) {
                    admittedIsSource.sort((a, b) => b["$admittedSortColumn"].compareTo(a["$admittedSortColumn"]));
                  } else {
                    admittedIsSource.sort((a, b) => a["$admittedSortColumn"].compareTo(b["$admittedSortColumn"]));
                  }
                });
              },
              sortAscending: admittedSortAscending,
              sortColumn: admittedSortColumn,
              isLoading: admittedIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => admittedSelecteds.add(item));
                } else {
                  setState(() => admittedSelecteds.removeAt(admittedSelecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => admittedSelecteds = admittedIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => admittedSelecteds.clear());
                }
              },
              footers: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Rows per page:"),
                ),
                if (admittedPerPage != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton(
                        value: admittedCurrentPerPage,
                        items: admittedPerPage
                            .map((e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            admittedCurrentPerPage = value;
                          });
                        }),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("$admittedCurrentPage - $admittedCurrentPerPage of $admittedTotal"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      admittedCurrentPage = admittedCurrentPage >= 2 ? admittedCurrentPage - 1 : 1;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    setState(() {
                      admittedCurrentPage++;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}