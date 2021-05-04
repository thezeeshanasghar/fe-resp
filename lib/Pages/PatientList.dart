import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Patients"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: PatientListForm(),
    );
  }
}

class PatientListForm extends StatefulWidget {
  @override
  _PatientListFormState createState() => _PatientListFormState();
}

class _PatientListFormState extends State<PatientListForm> {
  final formKey = GlobalKey<FormState>();

  String Status;
  String Stable;
  List<String> medicationList = ['Bed charges'];

  @override
  void initState() {
    super.initState();
    Status = "Status";
    Stable = "Stable";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            DataTable(
              columns: [
                DataColumn(
                    label: Text('Id',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Full Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),

                DataColumn(
                    label: Text('Sex',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('DOB',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Actions',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("1000M"), onTap: () {}),
                  DataCell(Text("Basit Shah"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Status,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Status = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Status'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(Text("24/04/2021"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Stable,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Stable = newValue;
                                });
                              },
                              items: <String>[
                                'Married',
                                'Single',
                                'Divorced',
                                'Child',
                                'Stable'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {},
                              child: Text(
                                "Consultation",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: Text(
                                "Procedure",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.lightBlue),
                              onPressed: () {},
                              child: Text(
                                "Admit",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ]),

                DataRow(cells: [
                  DataCell(Text("1200M"), onTap: () {}),
                  DataCell(Text("Anees Ahmad"), onTap: () {}),
                   DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Status,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Status = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Status'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(Text("26/05/2021"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Stable,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Stable = newValue;
                                });
                              },
                              items: <String>[
                                'Married',
                                'Single',
                                'Divorced',
                                'Child',
                                'Stable'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {},
                              child: Text(
                                "Consultation",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: Text(
                                "Procedure",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.lightBlue),
                              onPressed: () {},
                              child: Text(
                                "Admit",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("1200M"), onTap: () {}),
                  DataCell(Text("Anees Ahmad"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Status,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Status = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Status'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(Text("26/05/2021"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Stable,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Stable = newValue;
                                });
                              },
                              items: <String>[
                                'Married',
                                'Single',
                                'Divorced',
                                'Child',
                                'Stable'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {},
                              child: Text(
                                "Consultation",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: Text(
                                "Procedure",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.lightBlue),
                              onPressed: () {},
                              child: Text(
                                "Admit",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ]),

                DataRow(cells: [
                  DataCell(Text("1100M"), onTap: () {}),
                  DataCell(Text("Atif Shazad"), onTap: () {}),
                   DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Status,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Status = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Status'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(Text("26/06/2021"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Stable,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Stable = newValue;
                                });
                              },
                              items: <String>[
                                'Married',
                                'Single',
                                'Divorced',
                                'Child',
                                'Stable'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {},
                              child: Text(
                                "Consultation",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: Text(
                                "Procedure",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.lightBlue),
                              onPressed: () {},
                              child: Text(
                                "Admit",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ]),

                DataRow(cells: [
                  DataCell(Text("1000M"), onTap: () {}),
                  DataCell(Text("Zeeshan Khan"), onTap: () {}),
                   DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Status,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Status = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Status'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(Text("26/06/2021"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Stable,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Stable = newValue;
                                });
                              },
                              items: <String>[
                                'Married',
                                'Single',
                                'Divorced',
                                'Child',
                                'Stable'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {},
                              child: Text(
                                "Consultation",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: Text(
                                "Procedure",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.lightBlue),
                              onPressed: () {},
                              child: Text(
                                "Admit",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("1300M"), onTap: () {}),
                  DataCell(Text("Muhammad Irfan"), onTap: () {}),
                   DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Status,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Status = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Status'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(Text("09/07/2021"), onTap: () {}),
                  DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: Stable,
                              hint: Text("Gender"),
                              // icon: const Icon(Icons.arrow_circle_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Stable = newValue;
                                });
                              },
                              items: <String>[
                                'Married',
                                'Single',
                                'Divorced',
                                'Child',
                                'Stable'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                  DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {},
                              child: Text(
                                "Consultation",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: Text(
                                "Procedure",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(primary: Colors.lightBlue),
                              onPressed: () {},
                              child: Text(
                                "Admit",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ]),




                // DataRow(cells: [
                //   DataCell(Text("IV Injection"), onTap: () {}),
                //   DataCell(
                //       Padding(
                //         padding:
                //         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //         child: TextFormField(
                //           initialValue: '(optional)',
                //           decoration: InputDecoration(border: InputBorder.none),
                //           onFieldSubmitted: (val) {},
                //         ),
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: DropdownButton<String>(
                //               isExpanded: true,
                //               value: Status,
                //               hint: Text("Status"),
                //               // icon: const Icon(Icons.arrow_circle_down_sharp),
                //               iconSize: 24,
                //               elevation: 16,
                //               style: const TextStyle(color: Colors.grey),
                //               underline: Container(
                //                 height: 1,
                //                 color: Colors.grey,
                //               ),
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   Status = newValue;
                //                 });
                //               },
                //               items: <String>[
                //                 'Given',
                //                 'Pending',
                //                 'Status'
                //               ].map<DropdownMenuItem<String>>((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text("Save"),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   primary: Colors.green),
                //               onPressed: () {},
                //               child: Text(
                //                 "Duplicate",
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style:
                //               ElevatedButton.styleFrom(primary: Colors.red),
                //               onPressed: () {},
                //               child: Text(
                //                 "Remove",
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text("IV Injection"), onTap: () {}),
                //   DataCell(
                //       Padding(
                //         padding:
                //         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //         child: TextFormField(
                //           initialValue: '(optional)',
                //           decoration: InputDecoration(border: InputBorder.none),
                //           onFieldSubmitted: (val) {},
                //         ),
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: DropdownButton<String>(
                //               isExpanded: true,
                //               value: Status,
                //               hint: Text("Status"),
                //               // icon: const Icon(Icons.arrow_circle_down_sharp),
                //               iconSize: 24,
                //               elevation: 16,
                //               style: const TextStyle(color: Colors.grey),
                //               underline: Container(
                //                 height: 1,
                //                 color: Colors.grey,
                //               ),
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   Status = newValue;
                //                 });
                //               },
                //               items: <String>[
                //                 'Given',
                //                 'Pending',
                //                 'Status'
                //               ].map<DropdownMenuItem<String>>((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text("Save"),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   primary: Colors.green),
                //               onPressed: () {},
                //               child: Text(
                //                 "Duplicate",
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style:
                //               ElevatedButton.styleFrom(primary: Colors.red),
                //               onPressed: () {},
                //               child: Text(
                //                 "Remove",
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text("IV Injection"), onTap: () {}),
                //   DataCell(
                //       Padding(
                //         padding:
                //         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //         child: TextFormField(
                //           initialValue: '(optional)',
                //           decoration: InputDecoration(border: InputBorder.none),
                //           onFieldSubmitted: (val) {},
                //         ),
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: DropdownButton<String>(
                //               isExpanded: true,
                //               value: Status,
                //               hint: Text("Status"),
                //               // icon: const Icon(Icons.arrow_circle_down_sharp),
                //               iconSize: 24,
                //               elevation: 16,
                //               style: const TextStyle(color: Colors.grey),
                //               underline: Container(
                //                 height: 1,
                //                 color: Colors.grey,
                //               ),
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   Status = newValue;
                //                 });
                //               },
                //               items: <String>[
                //                 'Given',
                //                 'Pending',
                //                 'Status'
                //               ].map<DropdownMenuItem<String>>((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text("Save"),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   primary: Colors.green),
                //               onPressed: () {},
                //               child: Text(
                //                 "Duplicate",
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style:
                //               ElevatedButton.styleFrom(primary: Colors.red),
                //               onPressed: () {},
                //               child: Text(
                //                 "Remove",
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text("IV Injection"), onTap: () {}),
                //   DataCell(
                //       Padding(
                //         padding:
                //         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //         child: TextFormField(
                //           initialValue: '(optional)',
                //           decoration: InputDecoration(border: InputBorder.none),
                //           onFieldSubmitted: (val) {},
                //         ),
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: DropdownButton<String>(
                //               isExpanded: true,
                //               value: Status,
                //               hint: Text("Status"),
                //               // icon: const Icon(Icons.arrow_circle_down_sharp),
                //               iconSize: 24,
                //               elevation: 16,
                //               style: const TextStyle(color: Colors.grey),
                //               underline: Container(
                //                 height: 1,
                //                 color: Colors.grey,
                //               ),
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   Status = newValue;
                //                 });
                //               },
                //               items: <String>[
                //                 'Given',
                //                 'Pending',
                //                 'Status'
                //               ].map<DropdownMenuItem<String>>((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text("Save"),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   primary: Colors.green),
                //               onPressed: () {},
                //               child: Text(
                //                 "Duplicate",
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style:
                //               ElevatedButton.styleFrom(primary: Colors.red),
                //               onPressed: () {},
                //               child: Text(
                //                 "Remove",
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text("IV Injection"), onTap: () {}),
                //   DataCell(
                //       Padding(
                //         padding:
                //         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //         child: TextFormField(
                //           initialValue: '(optional)',
                //           decoration: InputDecoration(border: InputBorder.none),
                //           onFieldSubmitted: (val) {},
                //         ),
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: DropdownButton<String>(
                //               isExpanded: true,
                //               value: Status,
                //               hint: Text("Status"),
                //               // icon: const Icon(Icons.arrow_circle_down_sharp),
                //               iconSize: 24,
                //               elevation: 16,
                //               style: const TextStyle(color: Colors.grey),
                //               underline: Container(
                //                 height: 1,
                //                 color: Colors.grey,
                //               ),
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   Status = newValue;
                //                 });
                //               },
                //               items: <String>[
                //                 'Given',
                //                 'Pending',
                //                 'Status'
                //               ].map<DropdownMenuItem<String>>((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text("Save"),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   primary: Colors.green),
                //               onPressed: () {},
                //               child: Text(
                //                 "Duplicate",
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style:
                //               ElevatedButton.styleFrom(primary: Colors.red),
                //               onPressed: () {},
                //               child: Text(
                //                 "Remove",
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                // ]),
                // DataRow(cells: [
                //   DataCell(Text("IV Injection"), onTap: () {}),
                //   DataCell(
                //       Padding(
                //         padding:
                //         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //         child: TextFormField(
                //           initialValue: '(optional)',
                //           decoration: InputDecoration(border: InputBorder.none),
                //           onFieldSubmitted: (val) {},
                //         ),
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 0, vertical: 0),
                //             child: DropdownButton<String>(
                //               isExpanded: true,
                //               value: Status,
                //               hint: Text("Status"),
                //               // icon: const Icon(Icons.arrow_circle_down_sharp),
                //               iconSize: 24,
                //               elevation: 16,
                //               style: const TextStyle(color: Colors.grey),
                //               underline: Container(
                //                 height: 1,
                //                 color: Colors.grey,
                //               ),
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   Status = newValue;
                //                 });
                //               },
                //               items: <String>[
                //                 'Given',
                //                 'Pending',
                //                 'Status'
                //               ].map<DropdownMenuItem<String>>((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                //   DataCell(
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //             child: ElevatedButton(
                //               onPressed: () {},
                //               child: Text("Save"),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   primary: Colors.green),
                //               onPressed: () {},
                //               child: Text(
                //                 "Duplicate",
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                //             child: ElevatedButton(
                //               style:
                //               ElevatedButton.styleFrom(primary: Colors.red),
                //               onPressed: () {},
                //               child: Text(
                //                 "Remove",
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       onTap: () {}),
                // ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addRemoveButton(bool add, int index, List<String> list) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
      child: InkWell(
        onTap: () {
          if (add) {
            list.insert(0, null);
          } else {
            list.removeAt(index);
          }
          setState(() {});
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (add) ? Colors.grey[400] : Colors.red[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            (add) ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> widgetMedicationList() {
    List<Widget> medicationWidgetList = [];

    for (int i = 0; i < medicationList.length; i++) {
      medicationWidgetList.add(Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        medicationList[i].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _addRemoveButton(
                      i == medicationList.length - 1, i, medicationList)
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: Status,
                            hint: Text("Status"),
                            // icon: const Icon(Icons.arrow_circle_down_sharp),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                Status = newValue;
                              });
                            },
                            items: <String>['Given', 'Pending', 'Status']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Medication Name'),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          // FirstName = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: const Text('Save'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/BedTime');
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return medicationWidgetList;
  }
}
