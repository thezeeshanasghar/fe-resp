import 'package:flutter/foundation.dart';

class Invoice {
  final bool isSuccess;
  final String message;
  final List<InvoiceData> data;

  Invoice({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<InvoiceData> dataList =
        list.map((i) => InvoiceData.fromJson(i)).toList();
    return Invoice(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class InvoiceData {
  final int id;
  final String PaymentType;
  final String PreviousVisitDate;
  final String TodayVisitDate;
  final int ConsultationFee;
  final int Discount;
  final int Disposibles;
  final int GrossAmount;
  final int IsRefund;
  final int RefundAmount;

  InvoiceData({
    this.id,
    @required this.PaymentType,
    @required this.PreviousVisitDate,
    @required this.TodayVisitDate,
    @required this.ConsultationFee,
    @required this.Discount,
    @required this.Disposibles,
    @required this.GrossAmount,
    @required this.IsRefund,
    @required this.RefundAmount,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      id: json['id'],
      PaymentType: json['PaymentType'],
      PreviousVisitDate: json['PreviousVisitDate'],
      TodayVisitDate: json['TodayVisitDate'],
      ConsultationFee: json['ConsultationFee'],
      Discount: json['Discount'],
      Disposibles: json['Disposibles'],
      GrossAmount: json['GrossAmount'],
      IsRefund: json['IsRefund'],
      RefundAmount: json['RefundAmount'],
    );
  }

  Map<String, dynamic> toJson() => {
        "PaymentType": PaymentType,
        "PreviousVisitDate": PreviousVisitDate,
        "TodayVisitDate": TodayVisitDate,
        "ConsultationFee": ConsultationFee,
        "Discount": Discount,
        "Disposibles": Disposibles,
        "GrossAmount": GrossAmount,
        "IsRefund": IsRefund,
        "RefundAmount": RefundAmount,
      };
}
