class AddInvoiceRequest {
  int id;
  int doctorId;
  int patientId;
  int receptionistId;
  int appointmentId;
  String invoiceDate;
  String invoiceCheckupType;
  int invoiceCheckupFee;
  String invoicePaymentType;
  int invoiceDisposibles;
  int invoiceGrossAmount;
  String receiptPmid;
  int receiptDiscount;
  int receiptTotalAmount;
  int receiptPendingAmount;
  int receiptPaidAmount;
  String appointmentCode;
  String appointmentDate;
  String appointmentConsultationDate;
  String appointmentType;
  String appointmentPatientCategory;
  bool appointmentDetailsHasDischarged;
  String appointmentDetailsWalkinType;
  List<ProcedureList> procedureList;

  AddInvoiceRequest({
    this.id,
    this.doctorId,
    this.patientId,
    this.receptionistId,
    this.appointmentId,
    this.invoiceDate,
    this.invoiceCheckupType,
    this.invoiceCheckupFee,
    this.invoicePaymentType,
    this.invoiceDisposibles,
    this.invoiceGrossAmount,
    this.receiptPmid,
    this.receiptDiscount,
    this.receiptTotalAmount,
    this.receiptPendingAmount,
    this.receiptPaidAmount,
    this.appointmentCode,
    this.appointmentDate,
    this.appointmentConsultationDate,
    this.appointmentType,
    this.appointmentPatientCategory,
    this.appointmentDetailsHasDischarged,
    this.appointmentDetailsWalkinType,
    this.procedureList,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DoctorId'] = this.doctorId;
    data['PatientId'] = this.patientId;
    data['ReceptionistId'] = this.receptionistId;
    data['AppointmentId'] = this.appointmentId;
    data['InvoiceDate'] = this.invoiceDate;
    data['InvoiceCheckupType'] = this.invoiceCheckupType;
    data['InvoiceCheckupFee'] = this.invoiceCheckupFee;
    data['InvoicePaymentType'] = this.invoicePaymentType;
    data['InvoiceDisposibles'] = this.invoiceDisposibles;
    data['InvoiceGrossAmount'] = this.invoiceGrossAmount;
    data['ReceiptPmid'] = this.receiptPmid;
    data['ReceiptDiscount'] = this.receiptDiscount;
    data['ReceiptTotalAmount'] = this.receiptTotalAmount;
    data['ReceiptPendingAmount'] = this.receiptPendingAmount;
    data['ReceiptPaidAmount'] = this.receiptPaidAmount;
    data['AppointmentCode'] = this.appointmentCode;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointmentConsultationDate'] = this.appointmentConsultationDate;
    data['AppointmentType'] = this.appointmentType;
    data['AppointmentPatientCategory'] = this.appointmentPatientCategory;
    data['AppointmentDetailsHasDischarged'] =
        this.appointmentDetailsHasDischarged;
    data['AppointmentDetailsWalkinType'] = this.appointmentDetailsWalkinType;
    if (this.procedureList != null) {
      data['ProcedureList'] =
          this.procedureList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProcedureList {
  int id;
  int procedureId;
  int totalCharges;
  int count;
  bool procedureChecked;

  ProcedureList(
      {this.id,
      this.procedureId,
      this.totalCharges,
      this.procedureChecked,
      this.count});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProcedureId'] = this.procedureId;
    return data;
  }
}

class InvoiceSearchRequest {
  String search;
  String fromDate;
  String toDate;

  InvoiceSearchRequest({this.search, this.fromDate, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Search'] = this.search;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    return data;
  }
}
