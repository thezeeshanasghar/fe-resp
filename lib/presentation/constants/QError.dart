class QError {
  static const String emptyField = 'This field cannot be empty.';
  static const String emailLengthGreater =
      'A valid email cannot be more than 32 characters.';
  static const String emailLengthSmaller =
      'A valid email cannot be less than 6 characters.';
  static const String emailInvalid = 'Please enter a valid email.';
  static const String passwordLengthSmaller =
      'A valid password cannot be less than 8 characters.';
  static const String nameLengthGreater =
      'A valid name cannot be greater than 32 characters.';
  static const String nameLengthSmaller =
      'A valid name cannot be less than 2 characters.';
  static const String nameInvalid = 'Please enter a valid name.';
  static const String phoneLengthGreater =
      'A valid phone number cannot be greater than 11 characters.';
  static const String phoneLengthSmaller =
      'A valid phone cannot be less than 11 characters.';
  static const String phoneInvalid =
      'A valid phone number only contain digits.';
  static const String categoryInvalid = 'Please enter a valid category.';
  static const String cnicLengthGreater =
      'A valid cnic number cannot be greater than 13 characters.';
  static const String cnicLengthSmaller =
      'A valid cnic number cannot be less than 13 characters.';
  static const String cnicInvalid = 'A valid cnic number only contain digits.';
  static const String floorInvalid =
      'A valid floor number only contain digits.';
  static const String emptyInputFields =
      'Input Error: Some input fields are empty.\nTry Again: Fill all the compulsory fields to continue.';
  static const String dateInvalid =
      'Correct syntax: 2021-09-15\nPlease select a valid date to continue.';
  static const String intInvalid =
      'Input Error: Enter a valid digit to continue.';

  static const String emptyDatabase = 'Database is empty.';

  static const String dateFrom = '"From Date" must be smaller than "To Date".';
  static const String dateTo = '"To Date" must be greater than "From Date".';
}
