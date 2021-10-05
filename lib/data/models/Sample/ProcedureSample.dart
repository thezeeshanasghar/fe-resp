import 'package:flutter/material.dart';

class ProcedureSample {
  final int id;
  final String name;
  final String executant;
  final int charges;
  final int executantShare;
  TextEditingController tecCount = TextEditingController();
  TextEditingController tecTotal = TextEditingController(text: '0');
  bool procedureChecked = false;

  ProcedureSample({
    this.id,
    this.name,
    this.executant,
    this.charges,
    this.executantShare,
  });

  factory ProcedureSample.fromJson(Map<String, dynamic> json) {
    return ProcedureSample(
      id: json['id'],
      name: json['name'],
      executant: json['executant'],
      charges: json['charges'],
      executantShare: json['executantShare'],
    );
  }
}
