import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:flutter/material.dart';

class QErrorWidget extends StatelessWidget {
  const QErrorWidget({Key key, @required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          QPadding.globalErrorLeft, QPadding.globalErrorTop, QPadding.globalErrorRight, QPadding.globalErrorBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            error,
            style: QTextStyle.errorTextStyle,
          ),
        ],
      ),
    );
  }
}
