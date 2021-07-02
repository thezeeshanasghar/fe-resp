import 'package:baby_receptionist/Design/Strings.dart';
import 'package:flutter/foundation.dart';

class PatientInvoice {
  final bool isSuccess;
  final String message;
  final List<PatientInvoiceData> data;

  PatientInvoice({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory PatientInvoice.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<PatientInvoiceData> dataList =
        list.map((i) => PatientInvoiceData.fromJson(i)).toList();
    return PatientInvoice(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class PatientSingleInvoice {
  final bool isSuccess;
  final String message;
  final PatientInvoiceData data;

  PatientSingleInvoice({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory PatientSingleInvoice.fromJson(Map<String, dynamic> json) {
    return PatientSingleInvoice(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: PatientInvoiceData.fromJson(json['data']));
  }
}

class PatientInvoiceData {
  final int id;
  final int patientId;
  final String name;
  final String dob;
  final String email;
  final String contact;
  final String city;
  final String area;
  final String fatherHusbandName;
  final String sex;
  final String category;
  final String lastAppointmentDate;
  final int discount;
  final int appointmentId;
  final int netAmount;

  PatientInvoiceData({
    this.id,
    @required this.name,
    @required this.patientId,
    @required this.dob,
    @required this.email,
    @required this.contact,
    @required this.city,
    @required this.area,
    @required this.category,
    @required this.fatherHusbandName,
    @required this.sex,
    @required this.lastAppointmentDate,
    @required this.discount,
    @required this.netAmount,
    this.appointmentId,
  });

  factory PatientInvoiceData.fromJson(Map<String, dynamic> json) {
    return PatientInvoiceData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      contact: json['contact'],
      city: json['city'],
      patientId: json['patientId'],
      area: json['area'],
      category: json['category'],
      fatherHusbandName: json['fatherHusbandName'],
      sex: json['sex'],
      lastAppointmentDate: json['lastAppointmentDate'],
      discount: json['discount'],
      appointmentId: json['appointmentId'],
      netAmount: json['netAmount'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "patientId": patientId,
        "dob": dob,
        "email": email,
        "contact": contact,
        "city": city,
        "area": area,
        "category": category,
        "fatherHusbandName": fatherHusbandName,
        "sex": sex,
        "lastAppointmentDate": lastAppointmentDate,
        "discount": discount,
        "appointmentId": appointmentId,
        "netAmount": netAmount,
      };
}
