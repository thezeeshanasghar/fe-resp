import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text(QString.dialogLoading),
            ],
          ),
        ],
      ),
    );
  }
}
