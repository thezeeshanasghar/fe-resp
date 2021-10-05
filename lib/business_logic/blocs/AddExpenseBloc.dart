import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/validators/Validators.dart';
import 'package:baby_receptionist/data/models/Requests/ExpenseRequest.dart';
import 'package:baby_receptionist/data/models/Responses/ExpenseResponse.dart';
import 'package:baby_receptionist/data/service/ExpenseService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddExpenseBloc with Validators {
  GlobalProgressDialog globalProgressDialog;
  ExpenseService expenseService = ExpenseService();

  final _name = BehaviorSubject<String>();
  final _billType = BehaviorSubject<String>();
  final _paymentType = BehaviorSubject<String>();
  final _employeeOrVendor = BehaviorSubject<String>();
  final _voucherNo = BehaviorSubject<String>();
  final _category = BehaviorSubject<String>();
  final _totalBill = BehaviorSubject<String>();
  final _transactionDetail = BehaviorSubject<String>();

  Stream<String> get name => _name.stream.transform(globalStringValidator);

  Stream<String> get billType => _billType.stream.transform(billTypeValidator);

  Stream<String> get paymentType =>
      _paymentType.stream.transform(paymentTypeValidator);

  Stream<String> get employeeOrVendor =>
      _employeeOrVendor.stream.transform(nameValidator);

  Stream<String> get voucherNo =>
      _voucherNo.stream.transform(globalStringValidator);

  Stream<String> get category => _category.stream.transform(categoryValidator);

  Stream<String> get totalBill =>
      _totalBill.stream.transform(globalIntValidator);

  Stream<String> get transactionDetail =>
      _transactionDetail.stream.transform(globalStringValidator);

  Stream<bool> get isFormValid => Rx.combineLatest([
        name,
        billType,
        paymentType,
        employeeOrVendor,
        voucherNo,
        category,
        totalBill,
        transactionDetail,
      ], (values) => values.every((element) => true));

  Function(String) get changeEmployeeOrVendor => _employeeOrVendor.sink.add;

  Function(String) get changeBillType => _billType.sink.add;

  Function(String) get changePaymentType => _paymentType.sink.add;

  Function(String) get changeName => _name.sink.add;

  Function(String) get changeVoucherNo => _voucherNo.sink.add;

  Function(String) get changeCategory => _category.sink.add;

  Function(String) get changeTotalBill => _totalBill.sink.add;

  Function(String) get changeTransactionDetail => _transactionDetail.sink.add;

  void dispose() {
    _name.close();
    _billType.close();
    _paymentType.close();
    _employeeOrVendor.close();
    _voucherNo.close();
    _category.close();
    _totalBill.close();
    _transactionDetail.close();
  }

  ExpenseRequest setRequestData({int id = -1, int userId}) {
    return ExpenseRequest(
      id: id,
      userId: userId,
      name: _name.value,
      billType: _billType.value,
      paymentType: _paymentType.value,
      employeeOrVender: _employeeOrVendor.value,
      voucherNo: _voucherNo.value,
      category: _category.value,
      totalBill: int.parse(_totalBill.value),
      transactionDetail: _transactionDetail.value,
    );
  }

  void resetValuesInsideBloc() {
    _name.value = '';
    _billType.value = '';
    _paymentType.value = '';
    _employeeOrVendor.value = '';
    _voucherNo.value = '';
    _category.value = '';
    _totalBill.value = '';
    _transactionDetail.value = '';
  }

  Future<bool> checkTokenValidity(context) async {
    globalProgressDialog = GlobalProgressDialog(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(false,
        QString.dialogSubmitting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        return true;
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QString.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
        return false;
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          QColor.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
      return false;
    }
  }

  Future<bool> onInsertExpense(context, String token, int userId) async {
    try {
      ExpenseResponse expenseResponse = await expenseService.insertExpense(
          setRequestData(userId: userId), token);
      if (expenseResponse != null) {
        if (expenseResponse.isSuccess) {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalSuccess, expenseResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
          return true;
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalFailed, expenseResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
          return false;
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QString.errorNull, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
        return false;
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          QColor.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
      return false;
    }
  }

  Future<bool> onUpdateExpense(
      {@required context,
      @required String token,
      @required int userId,
      @required int id}) async {
    try {
      ExpenseResponse expenseResponse = await expenseService.updateExpense(
          setRequestData(id: id, userId: userId), token);
      if (expenseResponse != null) {
        if (expenseResponse.isSuccess) {
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
          return true;
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalFailed, expenseResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
          return false;
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QString.errorNull, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
        return false;
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          QColor.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
      return false;
    }
  }
}
