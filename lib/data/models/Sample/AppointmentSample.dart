import 'package:baby_receptionist/data/models/Sample/PatientSample.dart';

class AppointmentSample {
  final int id;
  final int patientId;
  final int doctorId;
  final int receptionistId;

  final String code;
  final String date;
  final String consultationDate;
  final String type;
  final String patientCategory;

  final PatientSample patient;

  AppointmentSample({
    this.id,
    this.patientId,
    this.doctorId,
    this.receptionistId,
    this.code,
    this.date,
    this.consultationDate,
    this.type,
    this.patient,
    this.patientCategory,
  });

  factory AppointmentSample.fromJson(Map<String, dynamic> json) {
    return AppointmentSample(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      receptionistId: json['receptionistId'],
      code: json['code'],
      date: json['date'],
      consultationDate: json['consultationDate'],
      type: json['type'],
      patientCategory: json['patientCategory'],
      patient: json['patient'] != null
          ? PatientSample.fromJson(json['patient'])
          : null,
    );
  }
}
