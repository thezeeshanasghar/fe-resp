import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/data/models/Responses/PatientResponse.dart';
import 'package:baby_receptionist/data/models/Sample/PatientSample.dart';
import 'package:baby_receptionist/data/service/PatientService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PatientListBloc {
  List<PatientSample> _sampleList;
  GlobalProgressDialog _gpdFontelico;
  PatientService _service = PatientService();

  final _source = BehaviorSubject<List<Map<String, dynamic>>>();

  Stream<List<Map<String, dynamic>>> get source => _source.stream;

  Function(List<Map<String, dynamic>>) get changeSource => _source.sink.add;

  void dispose() {
    _source.close();
    print('patient dispose');
  }

  List<Map<String, dynamic>> generateDataForTable(List<PatientSample> list) {
    List<Map<String, dynamic>> temporaryMap = [];
    for (PatientSample sample in list) {
      temporaryMap.add({
        "id": sample.id,
        "userId": sample.userId,
        "birthPlace": sample.birthPlace,
        "type": sample.type,
        "externalId": sample.externalId,
        "bloodGroup": sample.bloodGroup,
        "clinicSite": sample.clinicSite,
        "referredBy": sample.referredBy,
        "referredDate": sample.referredDate,
        "guardian": sample.guardian,
        "paymentProfile": sample.paymentProfile,
        "description": sample.description,
        "userType": sample.user.userType,
        "dateOfBirth": sample.user.dateOfBirth.substring(0, 10),
        "maritalStatus": sample.user.maritalStatus,
        "religion": sample.user.religion,
        "firstName": sample.user.firstName,
        "lastName": sample.user.lastName,
        "fatherHusbandName": sample.user.fatherHusbandName,
        "gender": sample.user.gender,
        "cnic": sample.user.cnic,
        "contact": sample.user.contact,
        "emergencyContact": sample.user.emergencyContact,
        "email": sample.user.email,
        "address": sample.user.address,
        "joiningDate": sample.user.joiningDate.substring(0, 10),
        "floorNo": sample.user.floorNo,
        "experience": sample.user.experience,
        "action": sample.id,
      });
    }
    return temporaryMap;
  }

  Future<bool> checkTokenValidity(
      {@required context,
      @required bool hasProgressBar,
      @required String dialogType}) async {
    if (hasProgressBar) {
      _gpdFontelico = GlobalProgressDialog(context);
      _gpdFontelico.showSimpleFontellicoProgressDialog(
          false, dialogType, SimpleFontelicoProgressDialogType.multilines);
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
      _source.addError('Catch Exception (token): ${exception.toString()}');
      GlobalSnackbar.showMessageUsingSnackBar(QColor.snackGlobalFailed,
          'Catch Exception (token): ${exception.toString()}', context);
      if (hasProgressBar) {
        _gpdFontelico.hideSimpleFontellicoProgressDialog();
      }
      return false;
    }
  }

  Future<void> getDataAndLinkToTable({@required String token}) async {
    try {
      PatientResponseList responseList =
          await _service.getPatients(token: token);
      if (responseList != null) {
        if (responseList.data != null) {
          if (responseList.data.length > 0) {
            _sampleList = responseList.data;
            List<Map<String, dynamic>> list = [];
            list.addAll(generateDataForTable(_sampleList));
            _source.sink.add(list);
            return;
          }
        }
      }
      _source.addError('${responseList.message}');
    } catch (exception) {
      _source.addError(
        'Catch Exception (get): ${exception.toString()}',
      );
    }
  }

  Future<void> searchDataAndLinkToTable(
      {@required String token, @required String search}) async {
    try {
      PatientResponseList responseList =
          await _service.searchPatients(search: search, token: token);
      if (responseList != null) {
        if (responseList.data != null) {
          if (responseList.data.length > 0) {
            List<PatientSample> sampleList = responseList.data;
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
      List<Map<String, dynamic>> list = [];
      _source.sink.add(list);
    }
  }
}
