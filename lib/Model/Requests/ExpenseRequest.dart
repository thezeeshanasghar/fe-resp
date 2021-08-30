class ExpenseRequest {
  final int id;

  final String billType;
  final String paymentType;
  final String employeeOrVender;
  final String voucherNo;
  final String expenseCategory;
  final String employeeName;
  final double totalBill;
  final String transactionDetail;

  ExpenseRequest({
    this.id,
    this.billType,
    this.paymentType,
    this.employeeOrVender,
    this.voucherNo,
    this.expenseCategory,
    this.employeeName,
    this.totalBill,
    this.transactionDetail,
  });

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BillType": billType,
        "PaymentType": paymentType,
        "EmployeeOrVender": employeeOrVender,
        "VoucherNo": voucherNo,
        "ExpenseCategory": expenseCategory,
        "EmployeeName": employeeName,
        "TotalBill": totalBill,
        "TransactionDetail": transactionDetail,
      };
}
