import 'package:baby_receptionist/Common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/Common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/Common/GlobalSnakbar.dart';
import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Model/Requests/ExpenseRequest.dart';
import 'package:baby_receptionist/Model/Responses/ExpenseResponse.dart';
import 'package:baby_receptionist/Providers/TokenProvider.dart';
import 'package:baby_receptionist/Service/ExpenseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:provider/provider.dart';
import 'package:baby_receptionist/Design/Strings.dart';

class NewExpense extends StatefulWidget {
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final formKey = GlobalKey<FormState>();
  String billType = 'Select Final Bill';
  String paymentType = 'Payment Option';
  String voucherNo;
  String finalBill;
  String cashPayment;

  String employeeOrVendor = 'Employee or Vendor';
  String voucherNumber;
  String expenseCategory = 'Choose Expense Category';
  String vendorName;
  String employeeName;
  double totalBill;
  String transactionDetails;
  GlobalProgressDialog globalProgressDialog;
  bool loadingButtonProgressIndicator = false;
  SimpleFontelicoProgressDialog _dialog;
  ExpenseService expenseService;
  bool hasChangeDependencies = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
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
        title: Text(Strings.titleAddExpense),
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
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        widgetfinalBill(),
                        widgetcashPayment(),
                        widgetemployeeOrVendor(),
                        widgetvoucherNumber(),
                        widgetexpenseCategory(),
                        widgetemployeeName(),
                        widgettotalBill(),
                        widgettransactionDetails(),
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

  Widget widgetfinalBill() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: billType,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                billType = newValue;
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

  Widget widgetcashPayment() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: paymentType,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                paymentType = newValue;
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

  Widget widgetvoucherNumber() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card), border: OutlineInputBorder(), labelText: 'Voucher Number'),
            validator: (String value) {
              int voucherNo = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              voucherNo = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetemployeeOrVendor() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: employeeOrVendor,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                employeeOrVendor = newValue;
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

  Widget widgetexpenseCategory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: expenseCategory,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                expenseCategory = newValue;
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

  Widget widgetemployeeName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Employee Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              employeeName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetvendorName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration:
                InputDecoration(icon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Vendor Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              vendorName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgettotalBill() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card), border: OutlineInputBorder(), labelText: 'Total Bill '),
            validator: (String value) {
              int _totalBill = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              totalBill = double.tryParse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget widgettransactionDetails() {
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
                prefixIcon: Icon(Icons.transform), border: OutlineInputBorder(), labelText: 'Transaction Details'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              transactionDetails = value;
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
              onPressed: () => onPressedSubmitButton(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onPressedSubmitButton() async {
    if (!formKey.currentState.validate()) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorInputValidation, context);
      return;
    }
    formKey.currentState.save();
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogSubmitting, SimpleFontelicoProgressDialogType.multilines);
    bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
    if (hasToken) {
      onCallingInsertExpense();
    } else {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  Future<void> onCallingInsertExpense() async {
    ExpenseService expenseService = ExpenseService();
    ExpenseResponse serviceResponse = await expenseService.insertExpense(
        ExpenseRequest(
            id: 0,
            billType: billType,
            paymentType: paymentType,
            employeeOrVender: employeeOrVendor,
            voucherNo: voucherNo,
            expenseCategory: expenseCategory,
            employeeName: employeeName,
            totalBill: totalBill,
            transactionDetail: transactionDetails),
        context.read<TokenProvider>().tokenSample.jwtToken);
    if (serviceResponse != null) {
      if (serviceResponse.isSuccess) {
        formKey.currentState.reset();
        resetValues();
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, serviceResponse.message, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, serviceResponse.message, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } else {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  void resetValues() {
    formKey.currentState.reset();
    setState(() {
       billType = 'Select Final Bill';
       paymentType = 'Payment Option';
       employeeOrVendor = 'Employee or Vendor';
       expenseCategory = 'Choose Expense Category';
    });
  }
}
