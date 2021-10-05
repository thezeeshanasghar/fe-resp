import 'package:baby_receptionist/business_logic/blocs/AddExpenseBloc.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:baby_receptionist/presentation/widgets/QErrorWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewExpense extends StatefulWidget {
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final formKey = GlobalKey<FormState>();
  final bloc = AddExpenseBloc();

  @override
  void initState() {
    super.initState();
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
        title: Text(QString.titleAddExpense),
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
                  minWidth: viewportConstraints.minWidth,
                ),
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetName() {
    return StreamBuilder<String>(
        stream: bloc.name,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeName,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_repair_service_outlined),
                      errorText: snapshot.error,
                      errorStyle: QTextStyle.errorTextStyle,
                      border: OutlineInputBorder(),
                      labelText: 'Expense'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetBillType() {
    return StreamBuilder<String>(
        stream: bloc.billType,
        builder: (context, snapshot) {
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
                        color: !snapshot.hasError
                            ? QColor.globalNormalInputBorder
                            : QColor.globalErrorInputBorder,
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
                      onChanged: bloc.changeBillType,
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
                if (snapshot.hasError) QErrorWidget(error: snapshot.error),
              ],
            ),
          );
        });
  }

  Widget widgetPaymentType() {
    return StreamBuilder<String>(
        stream: bloc.paymentType,
        builder: (context, snapshot) {
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
                        color: !snapshot.hasError
                            ? QColor.globalNormalInputBorder
                            : QColor.globalErrorInputBorder,
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
                      onChanged: bloc.changePaymentType,
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
                if (snapshot.hasError) QErrorWidget(error: snapshot.error),
              ],
            ),
          );
        });
  }

  Widget widgetEmployeeOrVendor() {
    return StreamBuilder<String>(
        stream: bloc.employeeOrVendor,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeEmployeeOrVendor,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outlined),
                      errorText: snapshot.error,
                      errorStyle: QTextStyle.errorTextStyle,
                      border: OutlineInputBorder(),
                      labelText: 'Employee/Vendor Name'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetVoucherNo() {
    return StreamBuilder<String>(
        stream: bloc.voucherNo,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeVoucherNo,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.card_membership_outlined),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Voucher No'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetCategory() {
    return StreamBuilder<String>(
        stream: bloc.category,
        builder: (context, snapshot) {
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
                        color: !snapshot.hasError
                            ? QColor.globalNormalInputBorder
                            : QColor.globalErrorInputBorder,
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
                      onChanged: bloc.changeCategory,
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
                if (snapshot.hasError) QErrorWidget(error: snapshot.error),
              ],
            ),
          );
        });
  }

  Widget widgetTotalBill() {
    return StreamBuilder<String>(
        stream: bloc.totalBill,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalInputFieldTop,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeTotalBill,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.money_outlined),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Total Bill'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetTransactionDetail() {
    return StreamBuilder<String>(
        stream: bloc.transactionDetail,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    QPadding.globalInputFieldLeft,
                    QPadding.globalZero,
                    QPadding.globalInputFieldRight,
                    QPadding.globalInputFieldBottom),
                child: TextFormField(
                  onChanged: bloc.changeTransactionDetail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description_outlined),
                      errorText: snapshot.error,
                      border: OutlineInputBorder(),
                      labelText: 'Transaction Detail'),
                ),
              ),
            ],
          );
        });
  }

  Widget widgetSubmit() {
    return StreamBuilder<bool>(
        stream: bloc.isFormValid,
        builder: (context, snapshot) {
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
                        if (snapshot.hasData) {
                          if (!snapshot.hasError) {
                            if (await bloc.checkTokenValidity(context)) {
                              if (await bloc.onInsertExpense(
                                  context,
                                  context
                                      .read<TokenProvider>()
                                      .tokenSample
                                      .jwtToken,
                                  context
                                      .read<TokenProvider>()
                                      .loginSample
                                      .userId)) {
                                formKey.currentState.reset();
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, QString.routeExpenseList);
                              }
                            }
                            return;
                          }
                        }
                        GlobalSnackbar.showMessageUsingSnackBar(
                            QColor.snackGlobalFailed,
                            QError.emptyInputFields,
                            context);
                      }),
                ),
              ),
            ],
          );
        });
  }
}
