import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/QColor.dart';
import '../../constants/QPadding.dart';
import '../../constants/QString.dart';
import '../../constants/QTextStyle.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  bool expenseIsLoading = false;
  bool hasChangeDependencies = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: QColor.globalBackgroundColor,
        appBar: AppBar(
          title: Text(QString.titleAppointmentList),
          backgroundColor: QColor.globalAppBarColor,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  QPadding.globalPaddingLeft,
                  QPadding.globalPaddingTop,
                  QPadding.globalPaddingRight,
                  QPadding.globalPaddingBottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: QPadding.rbSingle,
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Choose Appointment Type',
                                      style: QTextStyle.tableTypeHeader,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text(
                                        'Walk-in',
                                        style: QTextStyle.tableTypeValue,
                                      ),
                                      value: QString.tableTypeWalkIn,
                                      groupValue: () {},
                                      onChanged: (val) {},
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text(
                                        'Online',
                                        style: QTextStyle.tableTypeValue,
                                      ),
                                      value: QString.tableTypeOnline,
                                      groupValue: () {},
                                      onChanged: (val) {},
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text(
                                        'Admitted',
                                        style: QTextStyle.tableTypeValue,
                                      ),
                                      value: QString.tableTypeAdmitted,
                                      groupValue: () {},
                                      onChanged: (val) {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: QPadding.tableTypeAndTableDifference),
                ],
              )),
        ));
  }
}
