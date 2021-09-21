import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:flutter/material.dart';

class QTextStyle {
  static final errorTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.red[900],
    fontSize: 12,
  );

  static final compulsoryField = TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );

  static final searchField = TextStyle(
    fontWeight: FontWeight.normal,
    color: QColor.searchTextAndCursor,
  );

  static final searchPreference = TextStyle(
    fontWeight: FontWeight.normal,
    color: QColor.searchTextAndCursor,
  );

  static final tableTypeHeader = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static final tableTypeValue = TextStyle(
    fontWeight: FontWeight.w500,
  );

  static final tableHeaders = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static final tableNewInvoice = TextStyle(
    color: Colors.blueAccent,
  );
}
