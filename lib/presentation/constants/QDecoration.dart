import 'package:flutter/material.dart';

class QDecoration {
  static final searchFieldContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.grey[50],
    border: Border.all(color: Colors.grey[300]),
  );

  static final searchPreferenceContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: Colors.grey[300]),
  );

  static final searchPreferenceFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[300]),
  );

  static final searchPreferenceEnabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[300]),
  );
}
