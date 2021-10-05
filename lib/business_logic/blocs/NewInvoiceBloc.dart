import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/validators/Validators.dart';
import 'package:baby_receptionist/data/models/Arguments/InvoiceArguments.dart';
import 'package:baby_receptionist/data/models/Requests/InvoiceRequest.dart';
import 'package:baby_receptionist/data/models/Responses/DoctorResponse.dart';
import 'package:baby_receptionist/data/models/Responses/InvoiceResponse.dart';
import 'package:baby_receptionist/data/models/Responses/ProcedureResponse.dart';
import 'package:baby_receptionist/data/models/Sample/DoctorSample.dart';
import 'package:baby_receptionist/data/models/Sample/ProcedureSample.dart';
import 'package:baby_receptionist/data/models/Sample/UserSample.dart';
import 'package:baby_receptionist/data/service/DoctorService.dart';
import 'package:baby_receptionist/data/service/InvoiceService.dart';
import 'package:baby_receptionist/data/service/ProcedureService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class NewInvoiceBloc with Validators {
  GlobalProgressDialog _gpdFontelico;
  DoctorService _doctorService = DoctorService();
  ProcedureService _procedureService = ProcedureService();
  InvoiceService _invoiceService = InvoiceService();
  List<ProcedureList> _selectedProcedures = [];

  final _doctorList = BehaviorSubject<List<DoctorSample>>();
  final _procedureList = BehaviorSubject<List<ProcedureSample>>();
  final _ddbDoctor = BehaviorSubject<DoctorSample>();
  final _doctorTypeText = BehaviorSubject<String>();
  final _ddbInvoiceType = BehaviorSubject<String>();
  final _txtConsultationFee = BehaviorSubject<String>();
  final _loadingProcedure = BehaviorSubject<bool>();
  final _paymentType = BehaviorSubject<String>();
  final _totalAmount = BehaviorSubject<String>();
  final _discount = BehaviorSubject<String>();
  final _netTotal = BehaviorSubject<String>();
  final _disposible = BehaviorSubject<String>();
  final _grossTotal = BehaviorSubject<String>();

  Stream<List<DoctorSample>> get doctorList => _doctorList.stream;

  Stream<List<ProcedureSample>> get procedureList => _procedureList.stream;

  Stream<DoctorSample> get ddbDoctor => _ddbDoctor.stream;

  Stream<String> get doctorType => _doctorTypeText.stream;

  Stream<String> get ddbInvoiceType => _ddbInvoiceType.stream;

  Stream<String> get txtConsultationFee =>
      _txtConsultationFee.stream.transform(globalStringValidator);

  Stream<bool> get loadingProcedure => _loadingProcedure.stream;

  Stream<String> get paymentType => _paymentType.stream;

  Stream<String> get totalAmount =>
      _totalAmount.stream.transform(globalIntValidator);

  Stream<String> get discount => _discount.stream.transform(globalIntValidator);

  Stream<String> get netTotal => _netTotal.stream.transform(globalIntValidator);

  Stream<String> get disposible =>
      _disposible.stream.transform(globalIntValidator);

  Stream<String> get grossTotal =>
      _grossTotal.stream.transform(globalIntValidator);

  Stream<bool> get isFormValid => Rx.combineLatest([
        ddbDoctor,
        paymentType,
        totalAmount,
        discount,
        netTotal,
        disposible,
        grossTotal,
      ], (values) => values.every((element) => true));

  Function(List<ProcedureSample>) get changeProcedureList =>
      _procedureList.sink.add;

  Function(DoctorSample) get changeDdbDoctor => _ddbDoctor.sink.add;

  Function(String) get changeDoctorTypeText => _doctorTypeText.sink.add;

  Function(String) get changeInvoiceType => _ddbInvoiceType.sink.add;

  Function(String) get changeConsultationFee => _txtConsultationFee.sink.add;

  Function(bool) get changeLoadingProcedure => _loadingProcedure.sink.add;

  Function(String) get changePaymentType => _paymentType.sink.add;

  Function(String) get changeTotalAmount => _totalAmount.sink.add;

  Function(String) get changeDiscount => _discount.sink.add;

  Function(String) get changeNetTotal => _netTotal.sink.add;

  Function(String) get changeDisposible => _disposible.sink.add;

  Function(String) get changeGrossTotal => _grossTotal.sink.add;

  void dispose() {
    _doctorList.close();
    _procedureList.close();
    _ddbDoctor.close();
    _doctorTypeText.close();
    _ddbInvoiceType.close();
    _txtConsultationFee.close();
    _loadingProcedure.close();
    _paymentType.close();
    _totalAmount.close();
    _discount.close();
    _netTotal.close();
    _disposible.close();
    _grossTotal.close();
  }

  Future<bool> checkTokenValidity(
      {@required context,
      @required bool hasProgressBar,
      @required String dialogType}) async {
    if (hasProgressBar) {
      _gpdFontelico = GlobalProgressDialog(context);
      _gpdFontelico.showSimpleFontellicoProgressDialog(hasProgressBar,
          dialogType, SimpleFontelicoProgressDialogType.multilines);
    }
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        return true;
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QString.errorToken, context);
        _gpdFontelico.hideSimpleFontellicoProgressDialog();
        return false;
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(QColor.snackGlobalFailed,
          'Catch Exception (token): ${exception.toString()}', context);
      if (hasProgressBar) {
        _gpdFontelico.hideSimpleFontellicoProgressDialog();
      }
      return false;
    }
  }

  Future<void> getDoctorsAndLinkToForm({@required String token}) async {
    try {
      DoctorResponseList responseList =
          await _doctorService.getDoctors(token: token);
      if (responseList != null) {
        if (responseList.data != null) {
          if (responseList.data.length > 0) {
            List<DoctorSample> list = responseList.data;
            list.insert(
                0,
                DoctorSample(
                    id: -1,
                    specialityType: QString.txtDoctorType,
                    consultationFee: -1,
                    user: UserSample(
                        firstName: QString.dbffSelectDoctor, lastName: '')));
            _doctorList.sink.add(list);
            _ddbDoctor.sink.add(list[0]);
            return;
          }
        }
      }
      _doctorList.addError('${responseList.message}');
    } catch (exception) {
      _doctorList.addError(
        'Catch Exception (get): ${exception.toString()}',
      );
    }
  }

  Future<void> getProceduresAndLinkToForm({@required String token}) async {
    try {
      ProcedureResponseList responseList =
          await _procedureService.getProcedures(token: token);
      if (responseList != null) {
        if (responseList.data != null) {
          if (responseList.data.length > 0) {
            _procedureList.sink.add(responseList.data);
            return;
          }
        }
      }
      _procedureList.addError('${responseList.message}');
    } catch (exception) {
      _procedureList.addError(
        'Catch Exception (get): ${exception.toString()}',
      );
    }
  }

  void validateFields(context) {
    _paymentType.hasValue
        ? changePaymentType(_paymentType.value)
        : _paymentType.sink.addError(QError.emptyField);
    changeTotalAmount(_totalAmount.hasValue ? _totalAmount.value : '');
    changeDiscount(_discount.hasValue ? _discount.value : '');
    changeNetTotal(_netTotal.hasValue ? _netTotal.value : '');
    changeDisposible(_disposible.hasValue ? _disposible.value : '');
    changeGrossTotal(_grossTotal.hasValue ? _grossTotal.value : '');
    if (_ddbInvoiceType.value == 'Consultation') {
      changeConsultationFee(
          _txtConsultationFee.hasValue ? _txtConsultationFee.value : '');
    } else {
      _procedureList.value.forEach(
        (ProcedureSample element) {
          if (element.procedureChecked) {
            try {
              _selectedProcedures.add(
                ProcedureList(
                    id: -1,
                    procedureId: element.id,
                    totalCharges: int.parse(element.tecTotal.text),
                    procedureChecked: element.procedureChecked,
                    count: int.parse(element.tecCount.text)),
              );
            } catch (exception) {}
          }
        },
      );
    }
  }

  Future<bool> onInsertInvoice(
      {@required context,
      @required String token,
      @required InvoiceArguments invoiceArguments}) async {
    if (_ddbInvoiceType.value != 'Consultation') {
      if (_selectedProcedures.length > 0) {
        _selectedProcedures.forEach((ProcedureList element) {
          if (!element.procedureChecked) {
            GlobalSnackbar.showMessageUsingSnackBar(
                QColor.snackGlobalFailed, QError.procedureNotSelected, context);
            _gpdFontelico.hideSimpleFontellicoProgressDialog();
            print(element.procedureId);
            return false;
          }
        });
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QError.procedureNotSelected, context);
        _gpdFontelico.hideSimpleFontellicoProgressDialog();
        return false;
      }
    }
    try {
      InvoiceResponse invoiceResponse = await _invoiceService.insertInvoice(
          setRequestData(invoiceArguments), token);
      if (invoiceResponse != null) {
        if (invoiceResponse.isSuccess) {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalSuccess, invoiceResponse.message, context);
          _gpdFontelico.hideSimpleFontellicoProgressDialog();
          return true;
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalFailed, invoiceResponse.message, context);
          _gpdFontelico.hideSimpleFontellicoProgressDialog();
          return false;
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, QString.errorNull, context);
        _gpdFontelico.hideSimpleFontellicoProgressDialog();
        return false;
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          QColor.snackGlobalFailed, exception.toString(), context);
      _gpdFontelico.hideSimpleFontellicoProgressDialog();
      return false;
    }
  }

  AddInvoiceRequest setRequestData(InvoiceArguments invoiceArguments) {
    return AddInvoiceRequest(
      id: -1,
      doctorId: invoiceArguments.doctorId,
      patientId: invoiceArguments.patientId,
      receptionistId: invoiceArguments.receptionistId,
      appointmentId: invoiceArguments.appointmentId,
      invoiceDate: DateTime.now().toUtc().toString(),
      invoiceCheckupType: _ddbInvoiceType.value,
      invoiceCheckupFee: int.parse(_txtConsultationFee.value),
      invoiceDisposibles: int.parse(_disposible.value),
      invoiceGrossAmount: int.parse(_grossTotal.value),
      invoicePaymentType: _paymentType.value,
      receiptDiscount: int.parse(_discount.value),
      receiptPaidAmount: -1,
      receiptPendingAmount: -1,
      receiptPmid: '',
      receiptTotalAmount: int.parse(_totalAmount.value),
      procedureList:
          _ddbInvoiceType.value == 'Consultation' ? [] : _selectedProcedures,
      appointmentCode: invoiceArguments.appointmentCode,
      appointmentConsultationDate: invoiceArguments.appointmentConsultationDate,
      appointmentDate: invoiceArguments.appointmentDate,
      appointmentPatientCategory: invoiceArguments.appointmentPatientCategory,
      appointmentType: invoiceArguments.appointmentType,
    );
  }
}
