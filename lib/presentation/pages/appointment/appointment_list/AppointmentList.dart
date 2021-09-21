import 'dart:async';

import 'package:baby_receptionist/business_logic/blocs/AppointmentListBloc.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:baby_receptionist/presentation/constants/QTextStyle.dart';
import 'package:baby_receptionist/presentation/pages/appointment/appointment_list/WalkInAppointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  List<DatatableHeader> expenseHeaders = [];
  bool expenseIsLoading = false;
  bool hasChangeDependencies = false;
  final bloc = AppointmentListBloc();

  @override
  void initState() {
    super.initState();
    bloc.changeTableType('walkIn');
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
    bloc.dispose();
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
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.minHeight,
                  minWidth: viewportConstraints.minWidth,
                ),
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
                        _TableType(
                          bloc: bloc,
                        ),
                        SizedBox(
                          height: QPadding.tableTypeAndTableDifference,
                        ),
                        StreamBuilder<String>(
                            stream: bloc.tableType,
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  if (snapshot.data == 'walkIn')
                                    WalkInAppointment(bloc: bloc),
                                ],
                              );
                            }),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TableType extends StatelessWidget {
  const _TableType({Key key, @required this.bloc}) : super(key: key);
  final AppointmentListBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: bloc.tableType,
      builder: (context, snapshot) {
        return Card(
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
                            value: "walkIn",
                            groupValue: snapshot.data,
                            onChanged: bloc.changeTableType,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              'Online',
                              style: QTextStyle.tableTypeValue,
                            ),
                            value: "online",
                            groupValue: snapshot.data,
                            onChanged: bloc.changeTableType,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              'Admitted',
                              style: QTextStyle.tableTypeValue,
                            ),
                            value: "admitted",
                            groupValue: snapshot.data,
                            onChanged: bloc.changeTableType,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
