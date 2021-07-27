import 'package:flutter/foundation.dart';


class Expense {
  final bool isSuccess;
  final String message;
  final List<PatientExpense> data;

  Expense({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<PatientExpense> dataList =
    list.map((i) => PatientExpense.fromJson(i)).toList();
    return Expense(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class PatientExpense {
  final int id;
  final String BillType;
  final String PaymentType;
  final String EmployeeOrVender;
  final String VoucherNo;
  final String ExpenseCategory;
  final String EmployeeName;
  final int TotalBill;
  final String TransactionDetail;


  PatientExpense({
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

  factory PatientExpense.fromJson(Map<String, dynamic> json) {
    return PatientExpense(
      id: json['id'],
      BillType: json['billType'],
      PaymentType: json['paymentType'],
      EmployeeOrVender: json['employeeOrVender'],
      VoucherNo: json['voucherNo'],
      ExpenseCategory: json['expenseCategory'],
      EmployeeName: json['employeeName'],
      TotalBill: json['totalBill'],
      TransactionDetail: json['transactionDetail']
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