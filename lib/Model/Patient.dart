import 'package:flutter/foundation.dart';

class Patient {
  final bool isSuccess;
  final String message;
  final List<PatientData> data;

  Patient({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<PatientData> dataList =
        list.map((i) => PatientData.fromJson(i)).toList();
    return Patient(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class PatientData {
  final int id;
  final String name;
  final String sex;
  final String fatherHusbandName;
  final String email;
  final String cnic;
  final String city;
  final String localArea;
  final String dob;
  final String contact;
  final String patientDetails;
  final String placeofBirth;
  final String patientCategory;
  final String maritalStatus;
  final String patientType;
  final String externalId;
  final String bloodGroup;
  final String clinicSite;
  final String referedBy;
  final String referedDate;
  final String religion;
  final String patientGardian;
  final String paymentProfile;

  PatientData({
    this.id,
    @required this.name,
    @required this.sex,
    @required this.cnic,
    @required this.fatherHusbandName,
    @required this.email,
    @required this.city,
    @required this.localArea,
    @required this.dob,
    @required this.contact,
    @required this.patientDetails,
    @required this.placeofBirth,
    @required this.patientCategory,
    @required this.maritalStatus,
    @required this.patientType,
    @required this.externalId,
    @required this.bloodGroup,
    @required this.clinicSite,
    @required this.referedBy,
    @required this.referedDate,
    @required this.religion,
    @required this.patientGardian,
    @required this.paymentProfile,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
        id: json['id'],
        name: json['name'],
        sex: json['sex'],
        fatherHusbandName: json['fatherHusbandName'],
        email: json['email'],
        cnic: json['cnic'],
        city: json['city'],
        localArea: json['localArea'],
        dob: json['dob'],
        contact: json['contact'],
        patientDetails: json['patientDetails'],
        placeofBirth: json['placeofBirth'],
        patientCategory: json['patientCategory'],
        maritalStatus: json['maritalStatus'],
        patientType: json['patientType'],
        externalId: json['externalId'],
        bloodGroup: json['bloodGroup'],
        clinicSite: json['clinicSite'],
        referedBy: json['referedBy'],
        referedDate: json['referedDate'],
        religion: json['religion'],
        patientGardian: json['patientGardian'],
        paymentProfile: json['paymentProfile']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "sex": sex,
        "fatherHusbandName": fatherHusbandName,
        "email": email,
        "city": city,
        "localArea": localArea,
        "dob": dob,
        "cnic": cnic,
        "contact": contact,
        "patientDetails": patientDetails,
        "placeofBirth": placeofBirth,
        "patientCategory": patientCategory,
        "maritalStatus": maritalStatus,
        "patientType": patientType,
        "externalId": externalId,
        "bloodGroup": bloodGroup,
        "clinicSite": clinicSite,
        "referedBy": referedBy,
        "referedDate": referedDate,
        "religion": religion,
        "patientGardian": patientGardian,
        "paymentProfile": paymentProfile,
      };
}
