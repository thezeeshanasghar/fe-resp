import 'package:baby_receptionist/data/models/Sample/DoctorSample.dart';

class DoctorResponse {
  final bool isSuccess;
  final String message;
  final DoctorSample data;

  DoctorResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data:
            json['data'] != null ? DoctorSample.fromJson(json['data']) : null);
  }
}

class DoctorResponseList {
  final bool isSuccess;
  final String message;
  final List<DoctorSample> data;

  DoctorResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory DoctorResponseList.fromJson(Map<String, dynamic> json) {
    List<DoctorSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => DoctorSample.fromJson(i)).toList();
    }
    return DoctorResponseList(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
