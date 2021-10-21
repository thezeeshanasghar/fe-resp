import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/data/models/Requests/InvoiceRequest.dart';
import 'package:baby_receptionist/data/models/Responses/InvoiceResponse.dart';
import 'package:baby_receptionist/data/models/Sample/AppointmentSample.dart';
import 'package:baby_receptionist/data/models/Sample/InvoiceSample.dart';
import 'package:baby_receptionist/data/service/InvoiceService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class InvoiceListBloc {
  GlobalProgressDialog globalProgressDialog;
  InvoiceService invoiceService = InvoiceService();

  final _source = BehaviorSubject<List<Map<String, dynamic>>>();
  final _fromDate = BehaviorSubject<String>();
  final _toDate = BehaviorSubject<String>();

  Stream<List<Map<String, dynamic>>> get source => _source.stream;

  Stream<String> get fromDate => _fromDate.stream;

  Stream<String> get toDate => _toDate.stream;

  Function(List<Map<String, dynamic>>) get changeSource => _source.sink.add;

  Function(String) get changeFromDate => _fromDate.sink.add;

  Function(String) get changeToDate => _toDate.sink.add;

  void dispose() {
    _source.close();
    _fromDate.close();
    _toDate.close();
    print('invoice dispose');
  }

  List<Map<String, dynamic>> generateDataForTable(
      List<InvoiceSample> listOfInvoices) {
    List<Map<String, dynamic>> temp = [];
    for (InvoiceSample invoice in listOfInvoices) {
      temp.add({
        "id": invoice.id,
        "appointmentId": invoice.appointmentId,
        "patientId": invoice.patientId,
        "doctorId": invoice.doctorId,
        "receptionistId": invoice.receptionistId,
        "date": invoice.date.substring(0, 10),
        "checkupType": invoice.checkupType,
        "checkupFee": invoice.checkupFee,
        "paymentType": invoice.paymentType,
        "disposibles": invoice.disposibles,
        "grossAmount": invoice.grossAmount,
        "doctorSpecialityType": invoice.doctorSample.specialityType,
        "doctorFirstName": invoice.doctorSample.user.firstName,
        "doctorLastName": invoice.doctorSample.user.lastName,
        "doctorContact": invoice.doctorSample.user.contact,
        "receiptId": invoice.receiptSample.id,
        "receiptPmid": invoice.receiptSample.pmid,
        "receiptDiscount": invoice.receiptSample.discount,
        "receiptTotalAmount": invoice.receiptSample.totalAmount,
        "receiptPendingAmount": invoice.receiptSample.pendingAmount,
        "receiptPaidAmount": invoice.receiptSample.paidAmount,
        "patientFirstName": invoice.patientSample.user.firstName,
        "patientLastName": invoice.patientSample.user.lastName,
        "patientContact": invoice.patientSample.user.contact,
        "patientEmergencyContact": invoice.patientSample.user.emergencyContact,
      });
    }
    return temp;
  }

  Future<bool> checkTokenValidity(
      {@required context,
      @required bool hasProgressBar,
      @required String dialogType}) async {
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
      _source.addError('Catch Exception (token): ${exception.toString()}');
      GlobalSnackbar.showMessageUsingSnackBar(QColor.snackGlobalFailed,
          'Catch Exception (token): ${exception.toString()}', context);
      if (hasProgressBar) {
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
      return false;
    }
  }

  Future<void> searchDataAndLinkToTable(
      {@required context,
      @required String token,
      @required InvoiceSearchRequest searchRequest}) async {
    if (_fromDate.hasValue && _toDate.hasValue) {
      if (_fromDate.value.length > 0 && _toDate.value.length > 0) {
        if (DateTime.parse(_toDate.value)
            .isBefore(DateTime.parse(_fromDate.value))) {
          _fromDate.sink.addError(QError.dateFrom);
          _toDate.sink.addError(QError.dateTo);
          return;
        }
        searchRequest.toDate = _toDate.value;
        searchRequest.fromDate = _fromDate.value;
      }
    }

    try {
      InvoiceResponseList responseList =
          await invoiceService.searchInvoicesUsingPost(
              token: token, invoiceSearchRequest: searchRequest);
      if (responseList != null) {
        if (responseList.data != null) {
          if (responseList.data.length > 0) {
            List<InvoiceSample> sampleList = responseList.data;
            List<Map<String, dynamic>> list = [];
            list.addAll(generateDataForTable(sampleList));
            _source.sink.add(list);
            return;
          }
        }
      }
      List<Map<String, dynamic>> list = [];
      _source.sink.add(list);
    } catch (exception) {
      print(exception);
      List<Map<String, dynamic>> list = [];
      _source.sink.add(list);
    }
  }
}
