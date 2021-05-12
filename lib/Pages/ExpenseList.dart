import 'dart:math';

import 'package:baby_receptionist/Design/Dimens.dart';
import 'package:baby_receptionist/Design/Color.dart';
import 'package:baby_receptionist/Pages/NewInvoice.dart';
import 'package:baby_receptionist/Pages/Refund.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final formKey = GlobalKey<FormState>();

  // onCall Data
  List<DatatableHeader> onCallHeaders = [];
  List<int> onCallPerPage = [5, 10, 15, 100];
  int onCallTotal = 100;
  int onCallCurrentPerPage;
  int onCallCurrentPage = 1;
  bool onCallIsSearch = false;
  List<Map<String, dynamic>> onCallIsSource = [];
  List<Map<String, dynamic>> onCallSelecteds = [];
  String onCallSelectableKey = "Invoice";
  String onCallSortColumn;
  bool onCallSortAscending = true;
  bool onCallIsLoading = true;
  bool onCallShowSelect = false;

  @override
  void initState() {
    super.initState();
    // onCall
    initializeonCallHeaders();
    onCallInitData();
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
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimens.globalPaddingLeft,
                        Dimens.globalPaddingTop,
                        Dimens.globalPaddingRight,
                        Dimens.globalPaddingBottom),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[widgetonCallPatients()],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetonCallPatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
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
                  title: !onCallIsSearch
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.line_style_outlined),
                            ),
                            Text(
                              "Expense List",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : null,
                  actions: [
                    if (onCallIsSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    onCallIsSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!onCallIsSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              onCallIsSearch = true;
                            });
                          })
                  ],
                  headers: onCallHeaders,
                  source: onCallIsSource,
                  selecteds: onCallSelecteds,
                  showSelect: onCallShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    // print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      onCallSortColumn = value;
                      onCallSortAscending = !onCallSortAscending;
                      if (onCallSortAscending) {
                        onCallIsSource.sort((a, b) => b["$onCallSortColumn"]
                            .compareTo(a["$onCallSortColumn"]));
                      } else {
                        onCallIsSource.sort((a, b) => a["$onCallSortColumn"]
                            .compareTo(b["$onCallSortColumn"]));
                      }
                    });
                  },
                  sortAscending: onCallSortAscending,
                  sortColumn: onCallSortColumn,
                  isLoading: onCallIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => onCallSelecteds.add(item));
                    } else {
                      setState(() => onCallSelecteds
                          .removeAt(onCallSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => onCallSelecteds =
                          onCallIsSource.map((entry) => entry).toList().cast());
                    } else {
                      setState(() => onCallSelecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (onCallPerPage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: onCallCurrentPerPage,
                            items: onCallPerPage
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                onCallCurrentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "$onCallCurrentPage - $onCallCurrentPerPage of $onCallTotal"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          onCallCurrentPage = onCallCurrentPage >= 2
                              ? onCallCurrentPage - 1
                              : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          onCallCurrentPage++;
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

  // onCall
  List<Map<String, dynamic>> onCallGenerateData({int n: 100}) {
    final List sourceonCall = List.filled(n, Random.secure());
    List<Map<String, dynamic>> tempsonCall = [];
    var i = onCallIsSource.length;
    print(i);
    for (var data in sourceonCall) {
      tempsonCall.add({
        "No": i+1,
        "Date": "Feb 24, 2021",
        "Employee": "Syed Basit Ali Shah $i",
        "Vendor": "Vendor $i",
        "BalanceReceived": i + 100,
        "AdvanceIssued": "1000",
        "FinalBill": "$i 000",
        "Action": [i, 100],
      });
      i++;
    }
    return tempsonCall;
  }

  onCallInitData() async {
    setState(() => onCallIsLoading = true);
    Future.delayed(Duration(seconds: 0)).then((value) {
      onCallIsSource.addAll(onCallGenerateData(n: 100));
      setState(() => onCallIsLoading = false);
    });
  }

  initializeonCallHeaders() {
    onCallHeaders = [
      DatatableHeader(
          value: "No",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Date",
          show: true,
          flex: 1,
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
          value: "Employee",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Employee",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Vendor",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Vendor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "BalanceReceived",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Balance Received",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "AdvanceIssued",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Advance Issued",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FinalBill",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Final Bill",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 1,
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => NewInvoice()),
                      // );
                    },
                    child: Text('Adjust')),
              ],
            ));
          }),
    ];
  }
}
