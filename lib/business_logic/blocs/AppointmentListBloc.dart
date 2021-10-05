import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/data/models/Requests/AppointmentRequest.dart';
import 'package:baby_receptionist/data/models/Responses/AppointmentResponse.dart';
import 'package:baby_receptionist/data/models/Sample/AppointmentSample.dart';
import 'package:baby_receptionist/data/service/AppointmentService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AppointmentListBloc {
  List<AppointmentSample> _appointmentList;
  GlobalProgressDialog globalProgressDialog;
  AppointmentService appointmentService = AppointmentService();

  final _source = BehaviorSubject<List<Map<String, dynamic>>>();
  final _tableType = BehaviorSubject<String>();
  final _selectDoctor = BehaviorSubject<String>();
  final _fromDate = BehaviorSubject<String>();
  final _toDate = BehaviorSubject<String>();

  Stream<List<Map<String, dynamic>>> get source => _source.stream;

  Stream<String> get tableType => _tableType.stream;

  Stream<String> get selectDoctor => _selectDoctor.stream;

  Stream<String> get fromDate => _fromDate.stream;

  Stream<String> get toDate => _toDate.stream;

  Function(List<Map<String, dynamic>>) get changeSource => _source.sink.add;

  Function(String) get changeTableType => _tableType.sink.add;

  Function(String) get changeSelectDoctor => _selectDoctor.sink.add;

  Function(String) get changeFromDate => _fromDate.sink.add;

  Function(String) get changeToDate => _toDate.sink.add;

  void dispose() {
    _source.close();
    _tableType.close();
    _selectDoctor.close();
    _fromDate.close();
    _toDate.close();
    print('appointment dispose');
  }

  List<Map<String, dynamic>> generateDataForTable(
      List<AppointmentSample> listOfAppointments) {
    List<Map<String, dynamic>> tempExpense = [];
    for (AppointmentSample appointment in listOfAppointments) {
      tempExpense.add({
        "id": appointment.id,
        "patientId": appointment.patientId,
        "doctorId": appointment.doctorId,
        "receptionistId": appointment.receptionistId,
        "code": appointment.code,
        "date": appointment.date.substring(0, 10),
        "consultationDate": appointment.consultationDate.substring(0, 10),
        "type": appointment.type,
        "patientCategory": appointment.patientCategory,
        "userId": appointment.patient.userId,
        "birthPlace": appointment.patient.birthPlace,
        "patientType": appointment.patient.type,
        "externalId": appointment.patient.externalId,
        "bloodGroup": appointment.patient.bloodGroup,
        "clinicSite": appointment.patient.clinicSite,
        "referredBy": appointment.patient.referredBy,
        "referredDate": appointment.patient.referredDate,
        "guardian": appointment.patient.guardian,
        "paymentProfile": appointment.patient.paymentProfile,
        "description": appointment.patient.description,
        "userType": appointment.patient.user.userType,
        "dateOfBirth": appointment.patient.user.dateOfBirth,
        "maritalStatus": appointment.patient.user.maritalStatus,
        "religion": appointment.patient.user.religion,
        "firstName": appointment.patient.user.firstName,
        "lastName": appointment.patient.user.lastName,
        "fatherHusbandName": appointment.patient.user.fatherHusbandName,
        "gender": appointment.patient.user.gender,
        "cnic": appointment.patient.user.cnic,
        "contact": appointment.patient.user.contact,
        "emergencyContact": appointment.patient.user.emergencyContact,
        "email": appointment.patient.user.email,
        "address": appointment.patient.user.address,
        "joiningDate": appointment.patient.user.joiningDate,
        "floorNo": appointment.patient.user.floorNo,
        "experience": appointment.patient.user.experience,
        "action": appointment.id,
      });
    }
    return tempExpense;
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

  Future<void> getDataAndLinkToTable(
      {@required context,
      @required String token,
      @required String category}) async {
    try {
      AppointmentResponseList appointmentResponseList = await appointmentService
          .getAppointmentByCategory(token: token, category: category);
      if (appointmentResponseList != null) {
        if (appointmentResponseList.data != null) {
          if (appointmentResponseList.data.length > 0) {
            _appointmentList = appointmentResponseList.data;
            List<Map<String, dynamic>> list = [];
            list.addAll(generateDataForTable(_appointmentList));
            _source.sink.add(list);
            return;
          }
        }
      }
      _source.addError('${appointmentResponseList.message}');
    } catch (exception) {
      _source.addError(
        'Catch Exception (get): ${exception.toString()}',
      );
    }
  }

  Future<void> searchDataAndLinkToTable(
      {@required context,
      @required String token,
      @required AppointmentSearchRequest searchRequest}) async {
    if (_selectDoctor.hasValue) {
      if (_selectDoctor.value != QString.dbffSelectDoctor) {
        searchRequest.searchFrom = QString.searchFromCategoryAndDoctor;
      }
    }

    if (_fromDate.hasValue && _toDate.hasValue) {
      if (_fromDate.value.length > 0 && _toDate.value.length > 0) {
        if (DateTime.parse(_toDate.value)
            .isBefore(DateTime.parse(_fromDate.value))) {
          _fromDate.sink.addError(QError.dateFrom);
          _toDate.sink.addError(QError.dateTo);
          return;
        }
        searchRequest.dateTo = _toDate.value;
        searchRequest.dateFrom = _fromDate.value;
        searchRequest.searchFrom = QString.searchFromCategoryAndDate;
      }
    }

    if (_selectDoctor.hasValue && _fromDate.hasValue && _toDate.hasValue) {
      if (_selectDoctor.value != QString.dbffSelectDoctor &&
          _fromDate.value.length > 0 &&
          _toDate.value.length > 0) {
        if (DateTime.parse(_toDate.value)
            .isBefore(DateTime.parse(_fromDate.value))) {
          _fromDate.sink.addError(QError.dateFrom);
          _toDate.sink.addError(QError.dateTo);
          return;
        }
        searchRequest.doctor = _selectDoctor.value;
        searchRequest.dateTo = _toDate.value;
        searchRequest.dateFrom = _fromDate.value;
        searchRequest.searchFrom = QString.searchFromCategoryAndDoctorAndDate;
      }
    }

    try {
      AppointmentResponseList responseList = await appointmentService
          .searchAppointmentsUsingPost(token: token, request: searchRequest);
      if (responseList != null) {
        if (responseList.data != null) {
          if (responseList.data.length > 0) {
            List<AppointmentSample> sampleist = responseList.data;
            List<Map<String, dynamic>> list = [];
            list.addAll(generateDataForTable(sampleist));
            _source.sink.add(list);
            return;
          }
        }
      }
      List<Map<String, dynamic>> list = [];
      _source.sink.add(list);
    } catch (exception) {
      List<Map<String, dynamic>> list = [];
      _source.sink.add(list);
    }
  }
}
