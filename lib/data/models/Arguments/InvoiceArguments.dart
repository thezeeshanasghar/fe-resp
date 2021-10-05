class InvoiceArguments {
  final String previousDate;
  final String consultationDate;
  final String name;
  final String fatherName;
  final String dateOfBirth;
  final String email;
  final String contactNumber;

  final int doctorId;
  final int patientId;
  final int receptionistId;
  final int appointmentId;
  final String appointmentCode;
  final String appointmentDate;
  final String appointmentConsultationDate;
  final String appointmentType;
  final String appointmentPatientCategory;

  InvoiceArguments({
    this.previousDate,
    this.consultationDate,
    this.name,
    this.fatherName,
    this.dateOfBirth,
    this.email,
    this.contactNumber,
    this.doctorId,
    this.patientId,
    this.receptionistId,
    this.appointmentId,
    this.appointmentCode,
    this.appointmentConsultationDate,
    this.appointmentDate,
    this.appointmentPatientCategory,
    this.appointmentType,
  });
}
