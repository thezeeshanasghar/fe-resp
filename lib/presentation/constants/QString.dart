class QString {
  static const String titleHomePage = 'Home';
  static const String routeNewInvoice = '/NewInvoice';

  static const String titleAddPatient = 'Add Patient';
  static const String titleOnCallList = 'On Call List';
  static const String titleAddInvoice = 'New Invoice';
  static const String titleAddExpense = 'New Expense';
  static const String titleEditExpense = 'Edit Expense';
  static const String titlePatientList = 'Patient List';
  static const String titleExpenseList = 'Expense List';
  static const String titleShift = 'Shift Status';
  static const String titlePettyCashStart = 'Petty Cash Start';
  static const String titlePettyCashEnd = 'Petty Cash End';
  static const String titleAppointmentList = 'Appointment List';
  static const String titleInvoiceList = 'Invoice List';

  static const String titleLogin = 'Login';
  static const String routeNewExpense = '/NewExpense';
  static const String routeEditExpense = '/EditExpense';
  static const String routeOnCallList = '/OnCallList';
  static const String routeAddPatient = '/AddPatient';
  static const String routePatientList = '/PatientList';
  static const String routeExpenseList = '/ExpenseList';
  static const String routeShift = '/Shift';
  static const String routePettyCashStart = '/PettyCashStart';
  static const String routePettyCashEnd = '/PettyCashEnd';
  static const String routeAppointmentList = '/AppointmentList';
  static const String routeInvoiceList = '/InvoiceList';

  static const String apiPatientGet = 'api/patient/get';
  static const String apiPatientSearch = 'api/patient/search';
  static const String apiPatientInsert = 'api/patient/insert';
  static const String apiPatientUpdate = 'api/patient/update';
  static const String apiPatientDelete = 'api/patient/delete';

  static const String pathAPI = 'babymedics.fernflowers.com';
  static const String apiContentType = 'Content-Type';
  static const String apiApplicationJson = 'application/json; charset=UTF-8';
  static const String apiAuthorization = 'Authorization';
  static const String apiBearer = 'Bearer';

  static const String apiInvoiceGet = 'api/invoice/get';
  static const String apiInvoiceInsert = 'api/invoice/insert';
  static const String apiInvoiceUpdate = 'api/invoice/update';
  static const String apiInvoiceDelete = 'api/invoice/delete';
  static const String apiInvoicePostSearch = 'api/invoice/post/search';

  static const String apiExpenseGet = 'api/expense/get';
  static const String apiExpenseSearch = 'api/expense/search';
  static const String apiExpenseInsert = 'api/expense/insert';
  static const String apiExpenseUpdate = 'api/expense/update';
  static const String apiExpenseDelete = 'api/expense/delete';

  static const String apiAppointmentGet = 'api/appointment/get';
  static const String apiAppointmentGetById = 'api/appointment/get/id';
  static const String apiAppointmentGetByCategory =
      'api/appointment/get/category';
  static const String apiAppointmentSearch = 'api/appointment/search';
  static const String apiAppointmentPostSearch = 'api/appointment/post/search';

  static const String apiDoctorGet = 'api/doctor/get';
  static const String apiDoctorInsert = 'api/doctor/insert';
  static const String apiDoctorUpdate = 'api/doctor/update';
  static const String apiDoctorDelete = 'api/doctor/delete';

  static const String apiProcedureGet = 'api/procedure/get';
  static const String apiProcedureInsert = 'api/procedure/insert';
  static const String apiProcedureUpdate = 'api/procedure/update';
  static const String apiProcedureDelete = 'api/procedure/delete';

  static const String errorToken = 'Token Error: Try Again.';
  static const String errorNull = 'Null Error: Failed to call server.';
  static const String errorInputValidation =
      'Error: Some input fields are not filled.';

  static const String apiAuthenticationLogin = 'api/authentication/login';
  static const String apiAuthenticationRefresh = 'api/authentication/refresh';

  static const String submitGlobal = 'Submit';

  static const String dialogLoading = 'Loading...';
  static const String dialogPleaseWait = 'Please wait...';
  static const String dialogSubmitting = 'Submitting...';
  static const String dialogUpdating = 'Updating...';
  static const String dialogDeleting = 'Deleting...';

  static const String validationErrorEmpty = 'This field cannot be empty.';

  static const String defaultDate = '1900-01-01';
  static const String defaultString = '';
  static const int defaultInt = -1;
  static const String emptyString = '';

  static const String compulsoryField = ' *';
  static const String optionalField = '';

  static const String dbffChooseBillType = 'Choose Bill Type';
  static const String dbffChoosePaymentType = 'Choose Payment Type';
  static const String dbffChooseCategory = 'Choose Category';
  static const String dbffChooseGender = 'Choose Gender';

  static const String dbffSelectDoctor = 'Select Doctor';
  static const String dbffSelectDoctorType = 'Select Doctor Type';
  static const String dbffSelectBookedBy = 'Select Booked By';
  static const String dbffSelectInvoiceType = 'Select Invoice Type';
  static const String dbffSelectPaymentType = 'Select Payment Type';

  static const String txtDoctorType = 'Doctor Type';

  static const String rbSelectPatientCategory = 'Patient Category';
  static const String rbSelectPatientType = 'Patient Type';

  static const String alertDialogTitleDelete = 'Remove';
  static const String alertDialogTitleEdit = 'Action';
  static const String alertDialogTitleDeleteNote =
      'Are you sure you want to delete ';
  static const String alertDialogButtonDelete = 'Delete';
  static const String alertDialogButtonCancel = 'Cancel';

  static const String tableTypeWalkIn = 'walkin';
  static const String tableTypeOnline = 'online';
  static const String tableTypeAdmitted = 'admitted';

  static const String searchFromCategory = 'Category';
  static const String searchFromCategoryAndDoctor = 'CategoryAndDoctor';
  static const String searchFromCategoryAndDate = 'CategoryAndDate';
  static const String searchFromCategoryAndBooked = 'CategoryAndBooked';
  static const String searchFromCategoryAndDoctorAndDate =
      'CategoryAndDoctorAndDate';
  static const String searchFromCategoryAndDoctorAndBooked =
      'CategoryAndDoctorAndBooked';
  static const String searchFromCategoryAndDateAndBooked =
      'CategoryAndDateAndBooked';
  static const String searchFromCategoryAndDoctorAndDateAndBooked =
      'CategoryAndDoctorAndDateAndBooked';
}
