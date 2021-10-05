import 'dart:async';

import 'package:baby_receptionist/business_logic/blocs/AppointmentListBloc.dart';
import 'package:baby_receptionist/business_logic/blocs/InvoiceListBloc.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/data/models/Arguments/InvoiceArguments.dart';
import 'package:baby_receptionist/data/models/Requests/AppointmentRequest.dart';
import 'package:baby_receptionist/data/models/Requests/InvoiceRequest.dart';
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

class InvoiceList extends StatefulWidget {
  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  bool hasChangeDependencies = false;
  final bloc = InvoiceListBloc();
  final _tecToDate = TextEditingController();
  final _tecFromDate = TextEditingController();
  List<DatatableHeader> _headers = [];

  @override
  void initState() {
    super.initState();
    _tecFromDate.text = DateTime.now().toString().substring(0, 10);
    _tecToDate.text = DateTime.now().toString().substring(0, 10);
    bloc.changeFromDate(_tecFromDate.text);
    bloc.changeToDate(_tecToDate.text);
    _headers = initializeHeaders();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (!hasChangeDependencies) {
      if (await bloc.checkTokenValidity(
          context: context,
          hasProgressBar: false,
          dialogType: QString.dialogSubmitting)) {
        await bloc.searchDataAndLinkToTable(
          context: context,
          token: context.read<TokenProvider>().tokenSample.jwtToken,
          searchRequest: InvoiceSearchRequest(
            search: '',
          ),
        );
      }
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tecToDate.dispose();
    _tecFromDate.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QColor.globalBackgroundColor,
      appBar: AppBar(
        title: Text(QString.titleInvoiceList),
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
                                return widgetInvoiceList(snapshot.data);
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

  Widget widgetInvoiceList(List<Map<String, dynamic>> source) {
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
            onChanged: (String value) async {
              if (await bloc.checkTokenValidity(
                  context: context,
                  hasProgressBar: false,
                  dialogType: QString.dialogSubmitting)) {
                await bloc.searchDataAndLinkToTable(
                  context: context,
                  token: context.read<TokenProvider>().tokenSample.jwtToken,
                  searchRequest: InvoiceSearchRequest(
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
              widgetFromDate(),
              SizedBox(width: QPadding.searchPreferenceDifference),
              widgetToDate(),
            ],
          )
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
              stream: bloc.fromDate,
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
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 3)),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now(),
                              tecDate: _tecFromDate),
                        ),
                      ],
                    ),
                    errorText: snapshot.error,
                    labelStyle: QTextStyle.searchPreference,
                  ),
                  style: QTextStyle.searchPreference,
                  onChanged: (value) => bloc.changeFromDate(value),
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
              stream: bloc.toDate,
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
                                firstDate:
                                    DateTime.now().subtract(Duration(days: 3)),
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                                tecDate: _tecToDate),
                          ),
                        ],
                      ),
                      labelStyle: QTextStyle.searchPreference),
                  style: QTextStyle.searchPreference,
                  onChanged: bloc.changeToDate,
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
        bloc.changeFromDate(tecDate.text);
      } else if (dateType == searchDateType.toDate) {
        tecDate.text = date.toString().substring(0, 10);
        bloc.changeToDate(tecDate.text);
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
          value: "appointmentId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "appointmentId",
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
          value: "checkupType",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "checkupType",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "checkupFee",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "checkupFee",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "paymentType",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "paymentType",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "disposibles",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "disposibles",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "grossAmount",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "grossAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorSpecialityType",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorSpecialityType",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorFirstName",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorFirstName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorLastName",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorLastName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorContact",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorContact",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptId",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptId",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptPmid",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptPmid",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptDiscount",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptDiscount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptTotalAmount",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptTotalAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptPendingAmount",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptPendingAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptPaidAmount",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptPaidAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientFirstName",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientFirstName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientLastName",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientLastName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientContact",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientContact",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientEmergencyContact",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientEmergencyContact",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
    ];
    return headers;
  }
}
