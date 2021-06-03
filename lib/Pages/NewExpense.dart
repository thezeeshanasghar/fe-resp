import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Service/ExpenseService.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:baby_receptionist/Model/Expense.dart';
import 'dart:convert';
import 'package:baby_receptionist/Design/Strings.dart';


class NewExpense extends StatefulWidget {
  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final NewExpenseKey = GlobalKey<FormState>();
  String BillType;
  String PaymentType;
  String VoucherNo;
  String FinalBill = 'Select Final Bill';
  String CashPayment = 'Payment Option';
  String EmployeeOrVendor='Employee or Vendor';
  String VoucherNumber;
  String ExpenseCategory='Choose Expense Category';
  String VendorName;
  String EmployeeName;
  String TotalBill;
  String TransactionDetails;
  bool loadingButtonProgressIndicator = false;
  SimpleFontelicoProgressDialog _dialog;
  ExpenseService expenseService;
  @override
  void initState() {
    super.initState();
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
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
                  key: NewExpenseKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        widgetFinalBill(),
                        widgetCashPayment(),
                        widgetEmployeeOrVendor(),
                        widgetVoucherNumber(),
                        widgetExpenseCategory(),
                        widgetEmployeeName(),
                        widgetTotalBill(),
                        widgetTransactionDetails(),
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

  Widget widgetFinalBill() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: FinalBill,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                FinalBill = newValue;
              });
            },
            items: <String>[
              'Select Final Bill',
              'Option 1',
              'Option 2',
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

  Widget widgetCashPayment() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: CashPayment,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                CashPayment = newValue;
              });
            },
            items: <String>[
              'Payment Option',
              'Cash',
              'Credit Card',
              'Bank Transfer',
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

  Widget widgetVoucherNumber() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
                labelText: 'Voucher Number'),
            validator: (String value) {
              int _VoucherNumber = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              VoucherNumber = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetEmployeeOrVendor() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: EmployeeOrVendor,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                EmployeeOrVendor = newValue;
              });
            },
            items: <String>[
              'Employee or Vendor',
              'Employee',
              'Vendor',
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

  Widget widgetExpenseCategory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: ExpenseCategory,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                ExpenseCategory = newValue;
              });
            },
            items: <String>[
              'Choose Expense Category',
              'Utility Bills',
              'Medical',
              'Electrical',
              'Plumbing',
              'Cleaning',
              'Kitchen'
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

  Widget widgetEmployeeName() {
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
                labelText: 'Employee Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              EmployeeName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetVendorName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Vendor Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              VendorName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetTotalBill() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
                labelText: 'Total Bill '),
            validator: (String value) {
              int _TotalBill = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              TotalBill = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetTransactionDetails() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.transform),
                border: OutlineInputBorder(),
                labelText: 'Transaction Details'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              TransactionDetails = value;
            },
          ),
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
                // if (!NewExpenseKey.currentState.validate()) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content:
                //           Text('Error: Some input fields are not filled.')));
                //   return;
                // }
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text('Successfull')));
                // NewExpenseKey.currentState.save();
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
    if (!NewExpenseKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Text('Error: Some input fields are not filled')));
      return;
    }
    setState(() {
      loadingButtonProgressIndicator = true;
    });
    NewExpenseKey.currentState.save();
    _dialog.show(
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.multilines,  width: MediaQuery.of(context).size.width-50);

    Expense expense = new Expense(
        BillType: BillType,
        PaymentType: PaymentType,
        EmployeeOrVender: EmployeeOrVendor,
        VoucherNo: VoucherNo,
        ExpenseCategory: ExpenseCategory,
        EmployeeName: EmployeeName,
        TotalBill: TotalBill,
        TransactionDetail: TransactionDetails,
        );

    var json = jsonEncode(expense.toJson());
    print(json);

    var response = await expenseService.InsertExpense(expense);
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
              Text('Success: Created  Expense'),
            ],
          )));
      Navigator.pushNamed(context, Strings.titleHomePage);
      NewExpenseKey.currentState.reset();
    } else {
      _dialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to add Expense '),
            ],
          )));
      setState(() {
        loadingButtonProgressIndicator = false;
      });
    }
  }
}