class ExpenseSample {
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

  ExpenseSample({
    this.id,
    this.userId,
    this.name,
    this.billType,
    this.paymentType,
    this.employeeOrVender,
    this.voucherNo,
    this.category,
    this.totalBill,
    this.transactionDetail,
  });

  factory ExpenseSample.fromJson(Map<String, dynamic> json) {
    return ExpenseSample(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      billType: json['billType'],
      paymentType: json['paymentType'],
      employeeOrVender: json['employeeOrVender'],
      voucherNo: json['voucherNo'],
      category: json['category'],
      totalBill: json['totalBill'],
      transactionDetail: json['transactionDetail'],
    );
  }
}
