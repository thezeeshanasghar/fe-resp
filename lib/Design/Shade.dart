import 'dart:ui';

import 'package:flutter/material.dart';

class Shade {
  static final Color globalBackgroundColor = Colors.grey[100];
  static final Color globalAppBarColor = Colors.blueGrey;
  static final Color drawerHeaderColor = Colors.blueGrey;
  static final Color submitButtonColor = Colors.blueGrey;
  static final Color snackGlobalSuccess = Colors.blueGrey;
  static final Color snackGlobalFailed = Colors.red;

  static final Color alertBoxButtonTextDelete = Colors.red;
  static final Color alertBoxButtonTextCancel = Colors.blueAccent;

  static final Color actionButtonTextDelete = Colors.red;
  static final Color actionButtonTextEdit = Colors.blueAccent;


  static final Color elevatorButtonBackgroundStart = Colors.green;
  static final Color elevatorButtonBackgroundStop = Colors.red;

  static const String apiPatientGet = 'api/patient/get';
  static const String apiPatientInsert = 'api/patient/insert';
  static const String apiPatientUpdate = 'api/patient/update';
  static const String apiPatientDelete = 'api/patient/delete';


}
