import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnakbar.dart';
import 'package:baby_receptionist/data/models/Responses/ExpenseResponse.dart';
import 'package:baby_receptionist/data/models/Sample/ExpenseSample.dart';
import 'package:baby_receptionist/data/service/ExpenseService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ExpenseListBloc {
  List<ExpenseSample> _expenseList;
  final _expenseIsSource = BehaviorSubject<List<Map<String, dynamic>>>();

  GlobalProgressDialog globalProgressDialog;
  ExpenseService expenseService = ExpenseService();

  Stream<List<Map<String, dynamic>>> get expenseIsSource => _expenseIsSource;

  void dispose() {
    _expenseIsSource.close();
  }

  Future<bool> checkTokenValidity(
      context, bool hasProgressBar, String dialogType) async {
    if (hasProgressBar) {
      globalProgressDialog = GlobalProgressDialog(context);
      globalProgressDialog.showSimpleFontellicoProgressDialog(
          false, dialogType, SimpleFontelicoProgressDialogType.multilines);
    }
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
      _expenseIsSource
          .addError('Catch Exception (token): ${exception.toString()}');
      GlobalSnackbar.showMessageUsingSnackBar(QColor.snackGlobalFailed,
          'Catch Exception (token): ${exception.toString()}', context);
      if (hasProgressBar) {
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
      return false;
    }
  }

  Future<void> getDataAndLinkToTable(context, String token) async {
    try {
      ExpenseResponseList expenseResponseList =
          await expenseService.getExpenses(token);
      if (expenseResponseList != null) {
        if (expenseResponseList.data != null) {
          if (expenseResponseList.data.length > 0) {
            _expenseList = expenseResponseList.data;
            List<Map<String, dynamic>> list = [];
            list.addAll(generateDataForTable(_expenseList));
            _expenseIsSource.sink.add(list);
            return;
          }
        }
      }
      _expenseIsSource.addError('${expenseResponseList.message}');
    } catch (exception) {
      _expenseIsSource.addError(
        'Catch Exception (get): ${exception.toString()}',
      );
    }
  }

  Future<void> searchDataAndLinkToTable(
      context, String token, String search) async {
    try {
      ExpenseResponseList expenseResponseList =
          await expenseService.searchExpense(search: search, token: token);
      if (expenseResponseList != null) {
        if (expenseResponseList.data != null) {
          if (expenseResponseList.data.length > 0) {
            List<ExpenseSample> expenseSampleList = expenseResponseList.data;
            List<Map<String, dynamic>> list = [];
            list.addAll(generateDataForTable(expenseSampleList));
            _expenseIsSource.sink.add(list);
            return;
          }
        }
      }
      List<Map<String, dynamic>> list = [];
      _expenseIsSource.sink.add(list);
    } catch (exception) {
      List<Map<String, dynamic>> list = [];
      _expenseIsSource.sink.add(list);
    }
  }

  List<Map<String, dynamic>> generateDataForTable(
      List<ExpenseSample> listOfExpenses) {
    List<Map<String, dynamic>> tempExpense = [];
    for (ExpenseSample expense in listOfExpenses) {
      tempExpense.add({
        "id": expense.id,
        "userId": expense.userId,
        "name": expense.name,
        "billType": expense.billType,
        "paymentType": expense.paymentType,
        "employeeOrVender": expense.employeeOrVender,
        "voucherNo": expense.voucherNo,
        "category": expense.category,
        "totalBill": expense.totalBill,
        "transactionDetail": expense.transactionDetail,
        "action": expense.id,
      });
    }
    return tempExpense;
  }

  Future<void> onCallingDeleteExpense(context, token, row) async {
    try {
      ExpenseResponse expenseResponse =
          await expenseService.deleteExpense(row['id'], token);
      if (expenseResponse != null) {
        if (expenseResponse.isSuccess) {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalSuccess, expenseResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
          _expenseIsSource.value.remove(row);
          _expenseIsSource.sink.add(_expenseIsSource.value);
          return;
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalFailed, expenseResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QString.errorNull, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(QColor.snackGlobalFailed,
          'Catch Exception (delete): ${exception.toString()}', context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }
}
