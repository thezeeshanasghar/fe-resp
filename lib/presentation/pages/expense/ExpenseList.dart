import 'dart:async';

import 'package:baby_receptionist/business_logic/blocs/ExpenseListBloc.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/data/models/Requests/ExpenseRequest.dart';
import 'package:baby_receptionist/data/models/Sample/ExpenseSample.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/widgets/LoadingWidget.dart';
import 'package:baby_receptionist/presentation/widgets/NoteWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List<DatatableHeader> expenseHeaders = [];
  bool expenseIsLoading = false;
  bool hasChangeDependencies = false;
  final bloc = ExpenseListBloc();

  @override
  void initState() {
    super.initState();
    initializeExpenseHeaders();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (!hasChangeDependencies) {
      if (await bloc.checkTokenValidity(
          context, false, QString.dialogSubmitting)) {
        await bloc.getDataAndLinkToTable(
            context, context.read<TokenProvider>().tokenSample.jwtToken);
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
        title: Text(QString.titleExpenseList),
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
                            stream: bloc.expenseIsSource,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return NoteWidget(note: snapshot.error);
                              } else if (snapshot.hasData) {
                                return widgetExpenseList(snapshot.data);
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
        context, false, QString.dialogSubmitting)) {
      await bloc.getDataAndLinkToTable(
          context, context.read<TokenProvider>().tokenSample.jwtToken);
    }
  }

  Widget widgetExpenseList(List<Map<String, dynamic>> source) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 500,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ResponsiveDatatable(
                  actions: [
                    widgetSearchField(),
                  ],
                  headers: expenseHeaders,
                  source: source.length < 1 ? [] : source,
                  autoHeight: false,
                  onTabRow: (data) {
                    // print(data);
                  },
                  isLoading: expenseIsLoading,
                ),
              ),
            ),
          ]),
    );
  }

  Widget widgetSearchField() {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search_outlined),
            hintText: 'Search Expense'),
        onChanged: (String value) async {
          if (await bloc.checkTokenValidity(
              context, false, QString.dialogSubmitting)) {
            if (value.isEmpty) {
              await bloc.getDataAndLinkToTable(
                  context, context.read<TokenProvider>().tokenSample.jwtToken);
            } else {
              await bloc.searchDataAndLinkToTable(
                  context.read<TokenProvider>().tokenSample.jwtToken, value);
            }
          }
        },
      ),
    );
  }

  void initializeExpenseHeaders() {
    expenseHeaders = [
      DatatableHeader(
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "userId",
          show: false,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "User Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "name",
          show: true,
          flex: 1,
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
          value: "billType",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Bill Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "paymentType",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "P Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "employeeOrVender",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Employee/Vendor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "voucherNo",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Voucher No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "category",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "totalBill",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Total Bill",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "transactionDetail",
          show: false,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Transaction Detail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "action",
          show: true,
          flex: 2,
          sortable: false,
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
          sourceBuilder: (id, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    ExpenseRequest expenseRequest = ExpenseRequest(
                      id: row['id'],
                      name: row['name'],
                      transactionDetail: row['transactionDetail'],
                      totalBill: row['totalBill'],
                      category: row['category'],
                      voucherNo: row['voucherNo'],
                      employeeOrVender: row['employeeOrVender'],
                      paymentType: row['paymentType'],
                      billType: row['billType'],
                      userId: row['userId'],
                    );

                    Navigator.pushNamed(
                      context,
                      QString.routeEditExpense,
                      arguments: expenseRequest,
                    ).then((value) => onGoBack(value));
                  },
                  child: Text('Edit',
                      style: TextStyle(
                        color: QColor.actionButtonTextEdit,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () => showAlertDialog(row),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: QColor.actionButtonTextDelete,
                      ),
                    )),
              ],
            ));
          }),
    ];
  }

  void showAlertDialog(row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(QString.alertDialogButtonCancel,
          style: TextStyle(
              color: QColor.alertBoxButtonTextCancel,
              fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text(QString.alertDialogButtonDelete,
          style: TextStyle(
              color: QColor.alertBoxButtonTextDelete,
              fontWeight: FontWeight.w900)),
      onPressed: () async {
        Navigator.of(context).pop();
        if (await bloc.checkTokenValidity(
            context, true, QString.dialogDeleting)) {
          await bloc.onCallingDeleteExpense(
              context, context.read<TokenProvider>().tokenSample.jwtToken, row);
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Text(QString.alertDialogTitleDelete),
        ],
      ),
      content: Row(
        children: [
          Text(QString.alertDialogTitleDeleteNote),
          Text(
            row['name'] + ' ?',
            style: TextStyle(fontWeight: FontWeight.w100, color: Colors.red),
          )
        ],
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
      actionsPadding: EdgeInsets.fromLTRB(
          QPadding.actionsGlobalButtonLeft,
          QPadding.actionsGlobalButtonTop,
          QPadding.actionsGlobalButtonRight,
          QPadding.actionsGlobalButtonBottom),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
