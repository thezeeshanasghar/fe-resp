
import 'package:flutter/material.dart';


import '../../constants/QColor.dart';
import '../../constants/QPadding.dart';
import '../../constants/QString.dart';
import '../../constants/QTextStyle.dart';
import '../../widgets/QErrorWidget.dart';

class NewExpense extends StatefulWidget {
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final formKey = GlobalKey<FormState>();


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
    return Scaffold(
      backgroundColor: QColor.globalBackgroundColor,
      appBar: AppBar(
        title: Text(QString.titleAddExpense),
        centerTitle: false,
        backgroundColor: QColor.globalAppBarColor,
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalPaddingLeft,
                QPadding.globalPaddingTop,
                QPadding.globalPaddingRight,
                QPadding.globalPaddingBottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                widgetName(),
                widgetBillType(),
                widgetPaymentType(),
                widgetEmployeeOrVendor(),
                widgetVoucherNo(),
                widgetCategory(),
                widgetTotalBill(),
                widgetTransactionDetail(),
                widgetSubmit(),
              ],
            ),
          ),
        ),
      ) ,
    );
  }

  Widget widgetName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              QPadding.globalInputFieldLeft,
              QPadding.globalInputFieldTop,
              QPadding.globalInputFieldRight,
              QPadding.globalInputFieldBottom),
          child: TextFormField(
            onChanged:(val){},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.home_repair_service_outlined),

                errorStyle: QTextStyle.errorTextStyle,
                border: OutlineInputBorder(),
                labelText: 'Expense'),
          ),
        ),
      ],
    );
  }

  Widget widgetBillType() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          QPadding.globalDropDownFieldLeft,
          QPadding.globalDropDownFieldTop,
          QPadding.globalDropDownFieldRight,
          QPadding.globalDropDownFieldBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(


                  style: BorderStyle.solid),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  QPadding.globalDbffLeft,
                  QPadding.globalDbffTop,
                  QPadding.globalDbffRight,
                  QPadding.globalDbffBottom),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: QString.dbffChooseBillType,
                elevation: 16,
                decoration: InputDecoration.collapsed(
                  hintText: '',
                ),
                onChanged: (val){},
                items: <String>[
                  QString.dbffChooseBillType,
                  'Type 1',
                  'Type 2',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget widgetPaymentType() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          QPadding.globalDropDownFieldLeft,
          QPadding.globalDropDownFieldTop,
          QPadding.globalDropDownFieldRight,
          QPadding.globalDropDownFieldBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(

                  style: BorderStyle.solid),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  QPadding.globalDbffLeft,
                  QPadding.globalDbffTop,
                  QPadding.globalDbffRight,
                  QPadding.globalDbffBottom),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: QString.dbffChoosePaymentType,
                elevation: 16,
                decoration: InputDecoration.collapsed(
                  hintText: '',
                ),
                onChanged: (val){},
                items: <String>[
                  QString.dbffChoosePaymentType,
                  'Cash',
                  'Credit Card',
                  'Debit Card',
                  'Easypaisa',
                  'Jazz Cash',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget widgetEmployeeOrVendor() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              QPadding.globalInputFieldLeft,
              QPadding.globalInputFieldTop,
              QPadding.globalInputFieldRight,
              QPadding.globalInputFieldBottom),
          child: TextFormField(
            onChanged: (val){},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outlined),

                errorStyle: QTextStyle.errorTextStyle,
                border: OutlineInputBorder(),
                labelText: 'Employee/Vendor Name'),
          ),
        ),
      ],
    );
  }

  Widget widgetVoucherNo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              QPadding.globalInputFieldLeft,
              QPadding.globalInputFieldTop,
              QPadding.globalInputFieldRight,
              QPadding.globalInputFieldBottom),
          child: TextFormField(
            onChanged: (val){},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.card_membership_outlined),

                border: OutlineInputBorder(),
                labelText: 'Voucher No'),
          ),
        ),
      ],
    );
  }

  Widget widgetCategory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          QPadding.globalDropDownFieldLeft,
          QPadding.globalDropDownFieldTop,
          QPadding.globalDropDownFieldRight,
          QPadding.globalDropDownFieldBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(

                  style: BorderStyle.solid),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  QPadding.globalDbffLeft,
                  QPadding.globalDbffTop,
                  QPadding.globalDbffRight,
                  QPadding.globalDbffBottom),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: QString.dbffChooseCategory,
                elevation: 16,
                decoration: InputDecoration.collapsed(
                  hintText: '',
                ),
                onChanged: (val){},
                items: <String>[
                  QString.dbffChooseCategory,
                  'Category 1',
                  'Category 2',
                  'Category 3',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget widgetTotalBill() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              QPadding.globalInputFieldLeft,
              QPadding.globalInputFieldTop,
              QPadding.globalInputFieldRight,
              QPadding.globalInputFieldBottom),
          child: TextFormField(
            onChanged: (val){},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.money_outlined),

                border: OutlineInputBorder(),
                labelText: 'Total Bill'),
          ),
        ),
      ],
    );
  }

  Widget widgetTransactionDetail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              QPadding.globalInputFieldLeft,
              QPadding.globalZero,
              QPadding.globalInputFieldRight,
              QPadding.globalInputFieldBottom),
          child: TextFormField(
            onChanged: (val){},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),

                border: OutlineInputBorder(),
                labelText: 'Transaction Detail'),
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
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalInputFieldLeft,
                QPadding.globalInputFieldTop,
                QPadding.globalInputFieldRight,
                QPadding.globalInputFieldBottom),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: QColor.submitButtonColor,
                  minimumSize: Size(double.infinity, 45),
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
                child: Text('Submit'),
                onPressed: () async {

                }),
          ),
        ),
      ],
    );
  }
}
