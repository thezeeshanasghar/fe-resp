import 'dart:math';
import 'package:baby_receptionist/Design/Dimens.dart';
import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Expense.dart';
import 'package:baby_receptionist/Pages/NewInvoice.dart';
import 'package:baby_receptionist/Pages/Refund.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:baby_receptionist/Service/ExpenseService.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final formKey = GlobalKey<FormState>();

  // expense Data
  List<DatatableHeader> expenseHeaders = [];
  List<int> expensePerPage = [5, 10, 15, 100];
  int expenseTotal = 100;
  int expenseCurrentPerPage;
  int expenseCurrentPage = 1;
  bool expenseIsSearch = false;
  List<Map<String, dynamic>> expenseIsSource = [];
  List<Map<String, dynamic>> expenseSelecteds = [];
  List<PatientExpense> listExpenses;
  String expenseSelectableKey = "Invoice";
  String expenseSortColumn;
  bool expenseSortAscending = true;
  bool expenseIsLoading = true;
  bool expenseShowSelect = false;
  ExpenseService expenseService;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initializeexpenseHeaders();
    getExpensesFromApiAndLinkToTable();
    //expenseInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    expenseService = ExpenseService();
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleExpenseList),
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
                    padding: EdgeInsets.fromLTRB(
                        Dimens.globalPaddingLeft,
                        Dimens.globalPaddingTop,
                        Dimens.globalPaddingRight,
                        Dimens.globalPaddingBottom),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[widgetexpensePatients()],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetexpensePatients() {
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
                  title: !expenseIsSearch
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
                    if (expenseIsSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    expenseIsSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!expenseIsSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              expenseIsSearch = true;
                            });
                          })
                  ],
                  headers: expenseHeaders,
                  source: expenseIsSource,
                  selecteds: expenseSelecteds,
                  showSelect: expenseShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    // print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      expenseSortColumn = value;
                      expenseSortAscending = !expenseSortAscending;
                      if (expenseSortAscending) {
                        expenseIsSource.sort((a, b) => b["$expenseSortColumn"]
                            .compareTo(a["$expenseSortColumn"]));
                      } else {
                        expenseIsSource.sort((a, b) => a["$expenseSortColumn"]
                            .compareTo(b["$expenseSortColumn"]));
                      }
                    });
                  },
                  sortAscending: expenseSortAscending,
                  sortColumn: expenseSortColumn,
                  isLoading: expenseIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => expenseSelecteds.add(item));
                    } else {
                      setState(() => expenseSelecteds
                          .removeAt(expenseSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => expenseSelecteds =
                          expenseIsSource.map((entry) => entry).toList().cast());
                    } else {
                      setState(() => expenseSelecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (expensePerPage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: expenseCurrentPerPage,
                            items: expensePerPage
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                expenseCurrentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "$expenseCurrentPage - $expenseCurrentPerPage of $expenseTotal"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          expenseCurrentPage = expenseCurrentPage >= 2
                              ? expenseCurrentPage - 1
                              : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          expenseCurrentPage++;
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

  void initVariablesAndClasses() {
    expenseHeaders = [];
    expensePerPage = [5, 10, 15, 100];
    expenseTotal = 100;
    expenseCurrentPerPage;
    expenseCurrentPage = 1;
    expenseIsSearch = false;
    expenseIsSource = [];
    expenseSelecteds = [];
    expenseSelectableKey = "Invoice";
    expenseSortColumn;
    expenseSortAscending = true;
    expenseIsLoading = true;
    expenseShowSelect = false;
    listExpenses = [];
   // showSearchedList = false;
    expenseService = ExpenseService();
  }

  initializeexpenseHeaders() {
    expenseHeaders = [
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
          show: false,
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
          value: "BillType",
          show: true,
          flex: 2,
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
          value: "PaymentType",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Payment Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "EmployeeOrVender",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Employee / Vendor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "VoucherNo",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Voucher No.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "ExpenseCategory",
          show: true,
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
          value: "TotalBill",
          show: true,
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
          value: "TransactionDetail",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Transaction Details",
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

  void getExpensesFromApiAndLinkToTable() async {
    setState(() => expenseIsLoading = true);
    listExpenses = [];
    expenseIsSource = [];
    Expense expenseResponse = await expenseService.getExpenses();
    listExpenses = expenseResponse.data;
    print(listExpenses);
    expenseIsSource.addAll(generateExpenseDataFromApi(listExpenses));
    setState(() => expenseIsLoading = false);
  }

  List<Map<String, dynamic>> generateExpenseDataFromApi(
      List<PatientExpense> listOfExpenses) {
    List<Map<String, dynamic>> tempsexpense = [];
    for (PatientExpense expense in listOfExpenses) {
      tempsexpense.add({
        "Id": expense.id,
        "No": expense.id,
        "BillType": expense.BillType,
        "PaymentType": expense.PaymentType,
        "EmployeeOrVender": expense.EmployeeOrVender,
        "VoucherNo": expense.VoucherNo,
        "ExpenseCategory": expense.ExpenseCategory,
        "EmployeeName": expense.EmployeeName,
        "TotalBill": expense.TotalBill,
        "Action": expense.id,
      });
    }
    return tempsexpense;
  }
}
