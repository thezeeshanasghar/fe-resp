import 'package:flutter/foundation.dart';
class Expense {
  final int id;
  final String BillType;
  final String PaymentType;
  final String EmployeeOrVender;
  final String VoucherNo;
  final String ExpenseCategory;
  final String EmployeeName;
  final String TotalBill;
  final String TransactionDetail;


  Expense({
    this.id,
    @required this.BillType,
    @required this.PaymentType,
    @required this.EmployeeOrVender,
    @required this.VoucherNo,
    @required this.ExpenseCategory,
    @required this.EmployeeName,
    @required this.TotalBill,
    @required this.TransactionDetail
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      BillType: json['BillType'],
      PaymentType: json['PaymentType'],
      EmployeeOrVender: json['EmployeeOrVender'],
      VoucherNo: json['VoucherNo'],
      ExpenseCategory: json['ExpenseCategory'],
      EmployeeName: json['EmployeeName'],
      TotalBill: json['TotalBill'],
      TransactionDetail: json['TransactionDetail']
    );
  }

  Map<String, dynamic> toJson() => {
    "BillType": BillType,
    "PaymentType": PaymentType,
    "EmployeeOrVender": EmployeeOrVender,
    "VoucherNo": VoucherNo,
    "ExpenseCategory": ExpenseCategory,
    "EmployeeName": EmployeeName,
    "TotalBill": TotalBill,
    "TransactionDetail": TransactionDetail
  };
}