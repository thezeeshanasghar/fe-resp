import 'package:baby_receptionist/business_logic/blocs/AddExpenseBloc.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/data/models/Requests/ExpenseRequest.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:baby_receptionist/presentation/widgets/QErrorWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditExpense extends StatefulWidget {
  final ExpenseRequest arguments;

  const EditExpense({@required this.arguments});

  @override
  _EditExpenseState createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final formKey = GlobalKey<FormState>();
  final bloc = AddExpenseBloc();
  bool hasChangeDependencies = false;
  TextEditingController tecName = TextEditingController();
  TextEditingController tecEmployeeOrVendor = TextEditingController();
  TextEditingController tecVoucherNo = TextEditingController();
  TextEditingController tecTotalBill = TextEditingController();
  TextEditingController tecTransactionDetail = TextEditingController();

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
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
        title: Text(QString.titleEditExpense),
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

  void setValues() {
    tecName.text = widget.arguments.name;
    tecEmployeeOrVendor.text = widget.arguments.employeeOrVender;
    tecVoucherNo.text = widget.arguments.voucherNo;
    tecTotalBill.text = widget.arguments.totalBill.toString();
    tecTransactionDetail.text = widget.arguments.transactionDetail;

    bloc.changeName(widget.arguments.name);
    bloc.changeBillType(widget.arguments.billType);
    bloc.changePaymentType(widget.arguments.paymentType);
    bloc.changeEmployeeOrVendor(widget.arguments.employeeOrVender);
    bloc.changeVoucherNo(widget.arguments.voucherNo);
    bloc.changeCategory(widget.arguments.category);
    bloc.changeTotalBill(widget.arguments.totalBill.toString());
    bloc.changeTransactionDetail(widget.arguments.transactionDetail);
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
                  controller: tecName,
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
                      value: widget.arguments.billType.length < 1
                          ? QString.dbffChooseBillType
                          : widget.arguments.billType,
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
                      value: widget.arguments.paymentType.length < 1
                          ? QString.dbffChoosePaymentType
                          : widget.arguments.paymentType,
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
                  controller: tecEmployeeOrVendor,
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
                  controller: tecVoucherNo,
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
                      value: widget.arguments.category.length < 1
                          ? QString.dbffChooseCategory
                          : widget.arguments.category,
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
                  controller: tecTotalBill,
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
                  controller: tecTransactionDetail,
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
                              if (await bloc.onUpdateExpense(
                                  context: context,
                                  token: context
                                      .read<TokenProvider>()
                                      .tokenSample
                                      .jwtToken,
                                  id: widget.arguments.id,
                                  userId: widget.arguments.userId)) {
                                Navigator.pop(context);
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
