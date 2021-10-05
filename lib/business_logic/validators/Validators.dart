import 'dart:async';
import 'package:baby_receptionist/presentation/constants/QError.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';

mixin Validators {
  final globalStringValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (globalString, sink) {
    if (globalString.isEmpty) {
      return sink.addError(QError.emptyField);
    } else {
      sink.add(globalString);
    }
  });

  final globalIntValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (globalInt, sink) {
    if (globalInt.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (globalInt.isNotEmpty) {
      try {
        int.parse(globalInt);
        sink.add(globalInt);
      } catch (error) {
        return sink.addError(QError.intInvalid);
      }
    }
  });

  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (email.length > 32) {
      return sink.addError(QError.emailLengthGreater);
    } else if (email.length < 6) {
      return sink.addError(QError.emailLengthSmaller);
    } else if (!email.contains('@') || !email.contains('.com')) {
      return sink.addError(QError.emailInvalid);
    } else {
      sink.add(email);
    }
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (password.length < 8) {
      return sink.addError(QError.passwordLengthSmaller);
    } else {
      sink.add(password);
    }
  });

  final nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (name.length > 32) {
      return sink.addError(QError.nameLengthGreater);
    } else if (name.length < 2) {
      return sink.addError(QError.nameLengthSmaller);
    } else {
      sink.add(name);
    }
  });

  final phoneValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (phone.length < 11) {
      return sink.addError(QError.phoneLengthSmaller);
    } else if (phone.isNotEmpty) {
      try {
        int.parse(phone);
        sink.add(phone);
      } catch (error) {
        return sink.addError(QError.phoneInvalid);
      }
    }
  });

  final cnicValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (cnic, sink) {
    if (cnic.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (cnic.length < 13) {
      return sink.addError(QError.cnicLengthSmaller);
    } else if (cnic.isNotEmpty) {
      try {
        int.parse(cnic);
        sink.add(cnic);
      } catch (error) {
        return sink.addError(QError.cnicInvalid);
      }
    }
  });

  final floorValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (floor, sink) {
    if (floor.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (floor.isNotEmpty) {
      try {
        int.parse(floor);
        sink.add(floor);
      } catch (error) {
        return sink.addError(QError.floorInvalid);
      }
    }
  });

  final dateValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (date, sink) {
    if (date.isEmpty) {
      return sink.addError(QError.emptyField);
    } else if (date.isNotEmpty) {
      try {
        DateTime.parse(date);
        sink.add(date);
      } catch (error) {
        return sink.addError(QError.dateInvalid);
      }
    }
  });

  final dateOptionalValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (date, sink) {
    if (date.isNotEmpty) {
      try {
        DateTime.parse(date);
        sink.add(date);
      } catch (error) {
        return sink.addError(QError.dateInvalid);
      }
    } else {
      sink.add(date);
    }
  });

  final billTypeValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (billType, sink) {
    if (billType.isEmpty) {
      return sink.addError(QError.emptyField);
    }
    if (billType == QString.dbffChooseBillType) {
      return sink.addError(QError.emptyField);
    }
    sink.add(billType);
  });

  final paymentTypeValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (paymentType, sink) {
    if (paymentType.isEmpty) {
      return sink.addError(QError.emptyField);
    }
    if (paymentType == QString.dbffChoosePaymentType) {
      return sink.addError(QError.emptyField);
    }
    sink.add(paymentType);
  });

  final categoryValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (category, sink) {
    if (category.isEmpty) {
      return sink.addError(QError.emptyField);
    }
    if (category == QString.dbffChooseCategory) {
      return sink.addError(QError.emptyField);
    }
    sink.add(category);
  });

  final genderValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (gender, sink) {
    if (gender.isEmpty) {
      return sink.addError(QError.emptyField);
    }
    if (gender == QString.dbffChooseGender) {
      return sink.addError(QError.emptyField);
    }
    sink.add(gender);
  });

  final patientCategoryValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (patientCategory, sink) {
    if (patientCategory.isEmpty) {
      return sink.addError(QError.emptyField);
    }
    sink.add(patientCategory);
  });

  final patientTypeValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (patientType, sink) {
    if (patientType.isEmpty) {
      return sink.addError(QError.emptyField);
    }
    sink.add(patientType);
  });
}
