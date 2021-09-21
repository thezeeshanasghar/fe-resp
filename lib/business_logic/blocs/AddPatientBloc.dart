import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalRefreshToken.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnakbar.dart';
import 'package:baby_receptionist/business_logic/validators/Validators.dart';
import 'package:baby_receptionist/data/models/Requests/PatientRequest.dart';
import 'package:baby_receptionist/data/models/Responses/PatientResponse.dart';
import 'package:baby_receptionist/data/service/PatientService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddPatientBloc with Validators {
  GlobalProgressDialog globalProgressDialog;

  final _category = BehaviorSubject<String>();
  final _firstName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>.seeded('seedValue');
  final _fatherHusbandName = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _identityCard = BehaviorSubject<String>();
  final _contactNumber = BehaviorSubject<String>();
  final _emergencyContactNumber = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _joiningDate = BehaviorSubject<String>();
  final _dateOfBirth = BehaviorSubject<String>();
  final _floorNo = BehaviorSubject<String>();
  final _experience = BehaviorSubject<String>();
  final _patientType = BehaviorSubject<String>();
  final _status = BehaviorSubject<String>();
  final _religon = BehaviorSubject<String>();
  final _patientExternalId = BehaviorSubject<String>();
  final _bloodGroup = BehaviorSubject<String>();
  final _clinicSite = BehaviorSubject<String>();
  final _referredBy = BehaviorSubject<String>();
  final _referredDate = BehaviorSubject<String>();
  final _parentGuardian = BehaviorSubject<String>();
  final _paymentProfile = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();

  Stream<String> get category =>
      _category.stream.transform(patientCategoryValidator);

  Stream<String> get firstName => _firstName.stream.transform(nameValidator);

  Stream<String> get lastName => _lastName.stream.transform(nameValidator);

  Stream<String> get fatherHusbandName =>
      _fatherHusbandName.stream.transform(nameValidator);

  Stream<String> get gender => _gender.stream.transform(genderValidator);

  Stream<String> get identityCard =>
      _identityCard.stream.transform(cnicValidator);

  Stream<String> get contactNumber =>
      _contactNumber.stream.transform(phoneValidator);

  Stream<String> get emergencyContactNumber =>
      _emergencyContactNumber.stream.transform(phoneValidator);

  Stream<String> get email => _email.stream.transform(emailValidator);

  Stream<String> get address =>
      _address.stream.transform(globalStringValidator);

  Stream<String> get joiningDate =>
      _joiningDate.stream.transform(dateValidator);

  Stream<String> get dateOfBirth =>
      _dateOfBirth.stream.transform(dateValidator);

  Stream<String> get floorNo => _floorNo.stream.transform(floorValidator);

  Stream<String> get experience =>
      _experience.stream.transform(globalStringValidator);

  Stream<String> get patientType =>
      _patientType.stream.transform(patientTypeValidator);

  Stream<String> get status => _status.stream;

  Stream<String> get religon => _religon.stream;

  Stream<String> get patientExternalId => _patientExternalId.stream;

  Stream<String> get bloodGroup => _bloodGroup.stream;

  Stream<String> get clinicSite => _clinicSite.stream;

  Stream<String> get referredBy => _referredBy.stream;

  Stream<String> get referredDate =>
      _referredDate.stream.transform(dateOptionalValidator);

  Stream<String> get parentGuardian => _parentGuardian.stream;

  Stream<String> get paymentProfile => _paymentProfile.stream;

  Stream<String> get description => _description.stream;

  Stream<bool> get isFormValid => Rx.combineLatest([
        category,
        firstName,
        lastName,
        fatherHusbandName,
        gender,
        identityCard,
        contactNumber,
        emergencyContactNumber,
        email,
        address,
        joiningDate,
        dateOfBirth,
        floorNo,
        experience,
        patientType,
        referredDate,
      ], (values) => values.every((element) => true));

  Function(String) get changeFatherHusbandName => _fatherHusbandName.sink.add;

  Function(String) get changeFirstName => _firstName.sink.add;

  Function(String) get changeLastName => _lastName.sink.add;

  Function(String) get changeCategory => _category.sink.add;

  Function(String) get changeGender => _gender.sink.add;

  Function(String) get changeIdentityCard => _identityCard.sink.add;

  Function(String) get changeContactNumber => _contactNumber.sink.add;

  Function(String) get changeEmergencyContactNumber =>
      _emergencyContactNumber.sink.add;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeAddress => _address.sink.add;

  Function(String) get changeJoiningDate => _joiningDate.sink.add;

  Function(String) get changeDateOfBirth => _dateOfBirth.sink.add;

  Function(String) get changeFloorNo => _floorNo.sink.add;

  Function(String) get changeExperience => _experience.sink.add;

  Function(String) get changePatientType => _patientType.sink.add;

  Function(String) get changeStatus => _status.sink.add;

  Function(String) get changeReligon => _religon.sink.add;

  Function(String) get changePatientExternalId => _patientExternalId.sink.add;

  Function(String) get changeBloodGroup => _bloodGroup.sink.add;

  Function(String) get changeClinicSite => _clinicSite.sink.add;

  Function(String) get changeReferredBy => _referredBy.sink.add;

  Function(String) get changeReferredDate => _referredDate.sink.add;

  Function(String) get changeParentGuardian => _parentGuardian.sink.add;

  Function(String) get changePaymentProfile => _paymentProfile.sink.add;

  Function(String) get changeDescription => _description.sink.add;

  void dispose() {
    _category.close();
    _firstName.close();
    _lastName.close();
    _fatherHusbandName.close();
    _gender.close();
    _identityCard.close();
    _contactNumber.close();
    _emergencyContactNumber.close();
    _email.close();
    _address.close();
    _joiningDate.close();
    _dateOfBirth.close();
    _floorNo.close();
    _experience.close();
    _patientType.close();
    _status.close();
    _religon.close();
    _patientExternalId.close();
    _bloodGroup.close();
    _clinicSite.close();
    _referredBy.close();
    _referredDate.close();
    _parentGuardian.close();
    _paymentProfile.close();
    _description.close();
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

  Future<bool> onInsertPatient(context, String token) async {
    PatientService patientService = PatientService();
    try {
      PatientResponse patientResponse =
          await patientService.insertPatient(setRequestData(), token);
      if (patientResponse != null) {
        if (patientResponse.isSuccess) {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalSuccess, patientResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
          return true;
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              QColor.snackGlobalFailed, patientResponse.message, context);
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

  PatientRequest setRequestData() {
    return PatientRequest(
      category: _category.value,
      firstName: _firstName.value,
      lastName: _lastName.value,
      fatherHusbandName: _fatherHusbandName.value,
      gender: _gender.value,
      cnic: _identityCard.value,
      contact: _contactNumber.value,
      emergencyContact: _emergencyContactNumber.value,
      email: _email.value,
      address: _address.value,
      joiningDate: _joiningDate.value,
      dateOfBirth: _dateOfBirth.value,
      floorNo: int.parse(_floorNo.value),
      experience: _experience.value,
      type: _patientType.value,
      maritalStatus: _status.hasValue ? _status.value : QString.defaultString,
      religion: _religon.hasValue ? _religon.value : QString.defaultString,
      externalId: _patientExternalId.hasValue
          ? _patientExternalId.value
          : QString.defaultString,
      bloodGroup:
          _bloodGroup.hasValue ? _bloodGroup.hasValue : QString.defaultString,
      clinicSite:
          _clinicSite.hasValue ? _clinicSite.value : QString.defaultString,
      referredBy:
          _referredBy.hasValue ? _referredBy.value : QString.defaultString,
      referredDate:
          _referredDate.hasValue ? _referredDate.value : QString.defaultDate,
      guardian: _parentGuardian.hasValue
          ? _parentGuardian.value
          : QString.defaultString,
      paymentProfile: _paymentProfile.hasValue
          ? _paymentProfile.value
          : QString.defaultString,
      description:
          _description.hasValue ? _description.value : QString.defaultString,
      userType: 'Patient',
    );
  }
}
