import 'dart:async';

import 'package:baby_receptionist/business_logic/blocs/PatientListBloc.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QDecoration.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:baby_receptionist/presentation/widgets/LoadingWidget.dart';
import 'package:baby_receptionist/presentation/widgets/NoteWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:provider/provider.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<DatatableHeader> _headers = [];
  bool hasChangeDependencies = false;
  final bloc = PatientListBloc();

  @override
  void initState() {
    super.initState();
    _headers = initializeHeaders();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (!hasChangeDependencies) {
      if (await bloc.checkTokenValidity(
          context: context,
          hasProgressBar: false,
          dialogType: QString.dialogSubmitting)) {
        await bloc.getDataAndLinkToTable(
            token: context.read<TokenProvider>().tokenSample.jwtToken);
      }
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QColor.globalBackgroundColor,
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
                    padding: EdgeInsets.fromLTRB(
                        QPadding.globalPaddingLeft,
                        QPadding.globalPaddingTop,
                        QPadding.globalPaddingRight,
                        QPadding.globalPaddingBottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        StreamBuilder<List<Map<String, dynamic>>>(
                            stream: bloc.source,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return NoteWidget(note: snapshot.error);
                              } else if (snapshot.hasData) {
                                return widgetPatientList(snapshot.data);
                              } else {
                                return LoadingWidget();
                              }
                            })
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<FutureOr> onGoBack(dynamic value) async {
    if (await bloc.checkTokenValidity(
        context: context,
        hasProgressBar: false,
        dialogType: QString.dialogSubmitting)) {
      await bloc.getDataAndLinkToTable(
          token: context.read<TokenProvider>().tokenSample.jwtToken);
    }
  }

  Widget widgetPatientList(List<Map<String, dynamic>> source) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
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
            onChanged: (String search) async {
              if (await bloc.checkTokenValidity(
                  context: context,
                  hasProgressBar: false,
                  dialogType: QString.dialogSubmitting)) {
                if (search.isEmpty) {
                  await bloc.getDataAndLinkToTable(
                      token:
                          context.read<TokenProvider>().tokenSample.jwtToken);
                } else {
                  await bloc.searchDataAndLinkToTable(
                      token: context.read<TokenProvider>().tokenSample.jwtToken,
                      search: search);
                }
              }
            },
          ),
        ),
      ),
    );
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
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Birth Place",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "type",
          show: false,
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
          value: "externalId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "External Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "bloodGroup",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Blood Group",
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
                  "Clinic Site",
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
          show: true,
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
      DatatableHeader(
          value: "cnic",
          show: true,
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
          }),
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
          }),
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
          }),
      DatatableHeader(
          value: "email",
          show: false,
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
                    },
                    child: Text(
                      'New Invoice',
                      style: QTextStyle.tableNewInvoice,
                    )),
              ],
            ));
          }),
    ];
    return headers;
  }
}
