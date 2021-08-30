class PatientRequest {
  final int id;
  final int userId;

  final String userType;
  final String dateOfBirth;
  final String maritalStatus;
  final String religion;
  final String firstName;
  final String lastName;
  final String fatherHusbandName;
  final String gender;
  final String cnic;
  final String contact;
  final String emergencyContact;
  final String email;
  final String address;
  final String joiningDate;
  final int floorNo;
  final String experience;

  final String category;
  final String birthPlace;
  final String type;
  final String externalId;
  final String bloodGroup;
  final String clinicSite;
  final String referredBy;
  final String referredDate;
  final String guardian;
  final String paymentProfile;
  final String description;

  final String appointmentCode;
  final String consultationDate;
  final String appointmentType;

  PatientRequest({
    this.id,
    this.userId,
    this.userType,
    this.dateOfBirth,
    this.maritalStatus,
    this.religion,
    this.firstName,
    this.lastName,
    this.fatherHusbandName,
    this.gender,
    this.cnic,
    this.contact,
    this.emergencyContact,
    this.email,
    this.address,
    this.joiningDate,
    this.floorNo,
    this.experience,
    this.category,
    this.birthPlace,
    this.type,
    this.externalId,
    this.bloodGroup,
    this.clinicSite,
    this.referredBy,
    this.referredDate,
    this.guardian,
    this.paymentProfile,
    this.description,
    this.appointmentCode,
    this.consultationDate,
    this.appointmentType,
  });

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "UserType": userType,
        "DateOfBirth": dateOfBirth,
        "MaritalStatus": maritalStatus,
        "Religion": religion,
        "FirstName": firstName,
        "LastName": lastName,
        "FatherHusbandName": fatherHusbandName,
        "Gender": gender,
        "Cnic": cnic,
        "Contact": contact,
        "EmergencyContact": emergencyContact,
        "Email": email,
        "Address": address,
        "JoiningDate": joiningDate,
        "FloorNo": floorNo,
        "Experience": experience,
        "Category": category,
        "BirthPlace": birthPlace,
        "Type": type,
        "ExternalId": externalId,
        "BloodGroup": bloodGroup,
        "ClinicSite": clinicSite,
        "ReferredBy": referredBy,
        "ReferredDate": referredDate,
        "Guardian": guardian,
        "PaymentProfile": paymentProfile,
        "Description": description,
        "AppointmentCode": appointmentCode,
        "ConsultationDate": consultationDate,
        "AppointmentType": appointmentType,
      };
}
