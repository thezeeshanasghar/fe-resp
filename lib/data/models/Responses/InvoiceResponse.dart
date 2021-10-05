import 'package:baby_receptionist/data/models/Sample/InvoiceSample.dart';

class InvoiceResponse {
  final bool isSuccess;
  final String message;
  final InvoiceSample data;

  InvoiceResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data:
            json['data'] != null ? InvoiceSample.fromJson(json['data']) : null);
  }
}

class InvoiceResponseList {
  final bool isSuccess;
  final String message;
  final List<InvoiceSample> data;

  InvoiceResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory InvoiceResponseList.fromJson(Map<String, dynamic> json) {
    List<InvoiceSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => InvoiceSample.fromJson(i)).toList();
    }
    return InvoiceResponseList(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
