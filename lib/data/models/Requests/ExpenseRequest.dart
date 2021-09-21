import 'package:baby_receptionist/presentation/constants/QString.dart';

class ExpenseRequest {
  final int id;
  final int userId;

  final String name;
  final String billType;
  final String paymentType;
  final String employeeOrVender;
  final String voucherNo;
  final String category;
  final int totalBill;
  final String transactionDetail;

  ExpenseRequest({
    this.id = QString.defaultInt,
    this.userId = QString.defaultInt,
    this.billType,
    this.paymentType,
    this.employeeOrVender,
    this.voucherNo,
    this.category,
    this.name,
    this.totalBill = -1,
    this.transactionDetail,
  });

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Name": name,
        "BillType": billType,
        "PaymentType": paymentType,
        "EmployeeOrVender": employeeOrVender,
        "VoucherNo": voucherNo,
        "Category": category,
        "TotalBill": totalBill,
        "TransactionDetail": transactionDetail,
      };
}
