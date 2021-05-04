import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewExpense extends StatefulWidget {
  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("New Expense"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: NewExpenseForm(),
    );
  }
}

class NewExpenseForm extends StatefulWidget {
  @override
  _NewExpenseFormState createState() => _NewExpenseFormState();

}

class _NewExpenseFormState extends State<NewExpenseForm> {

  final NewExpenseFormKey = GlobalKey<FormState>();
  String FinalBill;
  String CashPayment;
  String EmployeeOrVender;
  String VoucherNumber;
  String ExpenseCategory;
  String VenderName;
  String EmployeeName;
  String TotalBill;
  String TransactionDetails;


  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.minHeight,
              ),
              child: Form(
                key: NewExpenseFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [
                        widgetFinalBill(),
                        widgetCashPayment(),
                        widgetEmployeeOrVender(),
                        widgetVoucherNumber(),
                        widgetExpenseCategory(),
                        widgetEmployeeName(),
                        widgetTotalBill(),
                        widgetTransactionDetails(),
                        widgetSubmit(),
                      ],

                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget widgetFinalBill() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: FinalBill,
            titleText: 'Final Bill',
            hintText: 'Final Bill',
            onSaved: (value) {
              setState(() {
                FinalBill = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                FinalBill = value;
              });
            },
            dataSource: [
              {
                "display": "F# 1",
                "value": "F# 1",
              },
              {
                "display": "F# 2",
                "value": "F# 2",
              },
              {
                "display": "F# 3",
                "value": "F# 3",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }
  Widget widgetCashPayment() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: CashPayment,
            titleText: 'Payment',
            hintText: 'Payment',
            onSaved: (value) {
              setState(() {
                CashPayment = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                CashPayment = value;
              });
            },
            dataSource: [
              {
                "display": "Cash",
                "value": "Cash",
              },
              {
                "display": "Credit Card",
                "value": "Credit_Card",
              },
              {
                "display": "Bank Transfer",
                "value": "Bank_Transfer",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
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
                icon: Icon(Icons.credit_card),
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
  Widget widgetEmployeeOrVender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: EmployeeOrVender,
            titleText: 'Select Employee',
            hintText: 'Employee',
            onSaved: (value) {
              setState(() {
                EmployeeOrVender = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                EmployeeOrVender = value;
              });
            },
            dataSource: [
              {
                "display": "Employee",
                "value": "Employee",
              },
              {
                "display": "Vender",
                "value": "Vender",
              },

            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }
  Widget widgetExpenseCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: ExpenseCategory,
            titleText: 'ExpenseCategory',
            hintText: 'ExpenseCategory',
            onSaved: (value) {
              setState(() {
                ExpenseCategory = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                ExpenseCategory = value;
              });
            },
            dataSource: [
              {
                "display": "IT",
                "value": "IT",
              },
              {
                "display": "Utlity Bills",
                "value": "Utlity Bills",
              },
              {
                "display": "Medical",
                "value": "Medical",
              },
              {
                "display": "Electrical",
                "value": "Electrical",
              },
              {
                "display": "Plumbing",
                "value": "Plumbing",
              },
              {
                "display": "Cleaning",
                "value": "Cleaning",
              },
              {
                "display": "Kitchen",
                "value": "Kitchen",
              },


            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
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
                icon: Icon(Icons.person),
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
  Widget widgetVenderName() {
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
                labelText: 'Vender Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              VenderName = value;
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
                icon: Icon(Icons.credit_card),
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
            minLines: 6,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            decoration: InputDecoration(
                icon: Icon(Icons.person),
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
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Submit'),
              onPressed: () {
                if (!NewExpenseFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content :
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfull')));
                NewExpenseFormKey.currentState.save();

              },
            ),
          ),
        ),
      ],
    );
  }
}
