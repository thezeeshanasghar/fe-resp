import 'package:flutter/material.dart';

class QDecoration {
  static final searchFieldContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.grey[50],
    border: Border.all(color: Colors.grey),
  );

  static final searchPreferenceContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: Colors.grey),
  );

  static final searchPreferenceFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  static final searchPreferenceEnabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );
}
