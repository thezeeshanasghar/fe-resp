import 'dart:async';

import 'package:baby_receptionist/business_logic/blocs/AppointmentListBloc.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/data/models/Requests/AppointmentRequest.dart';
import 'package:baby_receptionist/presentation/constants/QDecoration.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QEnum.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:baby_receptionist/presentation/widgets/LoadingWidget.dart';
import 'package:baby_receptionist/presentation/widgets/NoteWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:provider/provider.dart';

class AdmittedAppointment extends StatefulWidget {
  final AppointmentListBloc bloc;

  AdmittedAppointment({@required this.bloc});

  @override
  _AdmittedAppointmentState createState() => _AdmittedAppointmentState();
}

class _AdmittedAppointmentState extends State<AdmittedAppointment> {
  bool hasChangeDependencies = false;
  final _tecToDate = TextEditingController();
  final _tecFromDate = TextEditingController();
  List<DatatableHeader> _headers = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.changeSelectDoctor(QString.dbffSelectDoctor);
    widget.bloc.changeFromDate('');
    widget.bloc.changeToDate('');
    widget.bloc.changeSource(null);
    _headers = initializeHeaders();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (!hasChangeDependencies) {
      if (await widget.bloc.checkTokenValidity(
          context: context,
          hasProgressBar: false,
          dialogType: QString.dialogSubmitting)) {
        await widget.bloc.getDataAndLinkToTable(
            context: context,
            token: context.read<TokenProvider>().tokenSample.jwtToken,
            category: QString.tableTypeAdmitted);
      }
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tecToDate.dispose();
    _tecFromDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        StreamBuilder<List<Map<String, dynamic>>>(
            stream: widget.bloc.source,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return NoteWidget(note: snapshot.error);
              } else if (snapshot.hasData) {
                return widgetAdmittedAppointment(snapshot.data);
              } else {
                return LoadingWidget();
              }
            })
      ],
    );
  }

  Widget widgetAdmittedAppointment(List<Map<String, dynamic>> source) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widgetSearchPreference(),
            Container(
              margin: QPadding.tableMargins,
              constraints: QPadding.tableConstraints,
              child: ResponsiveDatatable(
                actions: [
                  widgetSearchField(),
                ],
                headers: _headers,
                source: source.length < 1 ? [] : source,
                autoHeight: false,
                onTabRow: (data) {
                  print(data);
                },
              ),
            ),
          ]),
    );
  }

  Widget widgetSearchField() {
    return Expanded(
      child: Padding(
        padding: QPadding.searchField,
        child: Container(
          decoration: QDecoration.searchFieldContainer,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            cursorColor: QColor.searchTextAndCursor,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: QColor.searchTextAndCursor,
                ),
                labelStyle: QTextStyle.searchField,
                focusColor: QColor.searchTextAndCursor,
                hintText: 'Search'),
            style: QTextStyle.searchField,
            onChanged: (String value) async {
              if (await widget.bloc.checkTokenValidity(
                  context: context,
                  hasProgressBar: false,
                  dialogType: QString.dialogSubmitting)) {
                await widget.bloc.searchDataAndLinkToTable(
                  context: context,
                  token: context.read<TokenProvider>().tokenSample.jwtToken,
                  searchRequest: AppointmentSearchRequest(
                    category: QString.tableTypeAdmitted,
                    searchFrom: QString.searchFromCategory,
                    booked: '1',
                    dateFrom: '1900-09-09',
                    dateTo: '1900-09-09',
                    doctor: '2',
                    search: value,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget widgetSearchPreference() {
    return Padding(
      padding: QPadding.searchPreference,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widgetSelectDoctor(),
              SizedBox(width: QPadding.searchPreferenceDifference),
              widgetFromDate(),
              SizedBox(width: QPadding.searchPreferenceDifference),
              widgetToDate(),
            ],
          )
        ],
      ),
    );
  }

  Widget widgetSelectDoctor() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: QDecoration.searchPreferenceContainer,
            child: Padding(
              padding: QPadding.searchPreferenceSelectDoctor,
              child: StreamBuilder<String>(
                  stream: widget.bloc.selectDoctor,
                  builder: (context, snapshot) {
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: snapshot.data,
                      elevation: 16,
                      style: QTextStyle.searchPreference,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: widget.bloc.changeSelectDoctor,
                      items: <String>[
                        QString.dbffSelectDoctor,
                        'Dr. Salman',
                        'Dr. Faisal',
                        'Dr. Nawaz',
                        'Dr. Sadia'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetFromDate() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: widget.bloc.fromDate,
              builder: (context, snapshot) {
                return TextFormField(
                  cursorColor: QColor.searchTextAndCursor,
                  controller: _tecFromDate,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: QDecoration.searchPreferenceFocusedBorder,
                    enabledBorder: QDecoration.searchPreferenceEnabledBorder,
                    focusColor: QColor.searchTextAndCursor,
                    labelText: 'From Date',
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: QColor.searchTextAndCursor,
                          ),
                          onPressed: () => _pickDate(
                              context: context,
                              dateType: searchDateType.fromDate,
                              firstDate: DateTime(DateTime.now().month - 1),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now(),
                              tecDate: _tecFromDate),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.clear_outlined,
                              color: QColor.searchTextAndCursor,
                            ),
                            onPressed: () {
                              _tecFromDate.text = '';
                              widget.bloc.changeFromDate('');
                            }),
                      ],
                    ),
                    errorText: snapshot.error,
                    labelStyle: QTextStyle.searchPreference,
                  ),
                  style: QTextStyle.searchPreference,
                  onChanged: (value) => widget.bloc.changeFromDate(value),
                );
              }),
        ],
      ),
    );
  }

  Widget widgetToDate() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: widget.bloc.toDate,
              builder: (context, snapshot) {
                return TextFormField(
                  cursorColor: QColor.searchTextAndCursor,
                  controller: _tecToDate,
                  readOnly: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: QDecoration.searchPreferenceFocusedBorder,
                      enabledBorder: QDecoration.searchPreferenceEnabledBorder,
                      focusColor: QColor.searchTextAndCursor,
                      labelText: 'To Date',
                      errorText: snapshot.error,
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.date_range_outlined,
                              color: QColor.searchTextAndCursor,
                            ),
                            onPressed: () => _pickDate(
                                context: context,
                                dateType: searchDateType.toDate,
                                firstDate: DateTime(DateTime.now().month - 1),
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                                tecDate: _tecToDate),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.clear_outlined,
                              color: QColor.searchTextAndCursor,
                            ),
                            onPressed: () {
                              _tecToDate.text = '';
                              widget.bloc.changeToDate('');
                            },
                          ),
                        ],
                      ),
                      labelStyle: QTextStyle.searchPreference),
                  style: QTextStyle.searchPreference,
                  onChanged: widget.bloc.changeToDate,
                );
              }),
        ],
      ),
    );
  }

  Future<void> _pickDate({
    @required initialDate,
    @required firstDate,
    @required lastDate,
    @required dateType,
    @required context,
    @required TextEditingController tecDate,
  }) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null) {
      if (dateType == searchDateType.fromDate) {
        tecDate.text = date.toString().substring(0, 10);
        widget.bloc.changeFromDate(tecDate.text);
      } else if (dateType == searchDateType.toDate) {
        tecDate.text = date.toString().substring(0, 10);
        widget.bloc.changeToDate(tecDate.text);
      }
    }
  }

  List<DatatableHeader> initializeHeaders() {
    List<DatatableHeader> headers = [
      DatatableHeader(
          value: "id",
          show: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Patient Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Doctor Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receptionistId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receptionistId",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "code",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Code",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "date",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Date",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "consultationDate",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Consultation Date",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "type",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Type",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientCategory",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Patient Category",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "userId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "User Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "birthPlace",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "birthPlace",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientType",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Patient Type",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "externalId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "externalId",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "bloodGroup",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "bloodGroup",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "clinicSite",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "clinicSite",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "referredBy",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "referredBy",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "referredDate",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "referredDate",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "guardian",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "guardian",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "paymentProfile",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "paymentProfile",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
        value: "description",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "description",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "userType",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "userType",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "dateOfBirth",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "dateOfBirth",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "maritalStatus",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "maritalStatus",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "religion",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "religion",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "firstName",
        show: true,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "firstName",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "lastName",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "lastName",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "fatherHusbandName",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "fatherHusbandName",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "gender",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "gender",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "cnic",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "cnic",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "contact",
        show: true,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "contact",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "emergencyContact",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "emergencyContact",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "email",
        show: true,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "email",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "address",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "address",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "joiningDate",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "joiningDate",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "floorNo",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "floorNo",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
        value: "experience",
        show: false,
        flex: 1,
        textAlign: TextAlign.center,
        headerBuilder: (value) {
          return Padding(
            padding: QPadding.tableHeaders,
            child: Center(
              child: Text(
                "experience",
                style: QTextStyle.tableHeaders,
              ),
            ),
          );
        },
      ),
      DatatableHeader(
          value: "action",
          show: true,
          flex: 1,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Action",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          },
          sourceBuilder: (id, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    GlobalSnackbar.showMessageUsingSnackBar(
                        Colors.black26, 'working on it', context);
                    Navigator.pushNamed(context, QString.routeNewInvoice);
                  },
                  child: Text('New Invoice', style: QTextStyle.tableNewInvoice),
                ),
              ],
            ));
          }),
    ];
    return headers;
  }
}
