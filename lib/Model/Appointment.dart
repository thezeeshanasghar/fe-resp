import 'package:flutter/foundation.dart';
class AppointmentModal {
  final int id;
  final int PatientId;
  final String AppointmentCode;
  final String AppointmentDate;
  final String AppointmentType;


  AppointmentModal({
    this.id,
    @required this.PatientId,
    @required this.AppointmentCode,
    @required this.AppointmentDate,
    @required this.AppointmentType,

  });

  factory AppointmentModal.fromJson(Map<String, dynamic> json) {
    return AppointmentModal(
        id: json['id'],
        PatientId: json['PatientId'],
        AppointmentCode: json['AppointmentCode'],
        AppointmentDate: json['AppointmentDate'],
        AppointmentType: json['AppointmentType'],
        );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "PatientId": PatientId,
    "AppointmentCode": AppointmentCode,
    "AppointmentDate": AppointmentDate,
    "AppointmentType": AppointmentType,

  };
}