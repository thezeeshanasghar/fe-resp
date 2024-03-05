
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import '../../business_logic/common/GlobalProgressDialog.dart';
import '../../business_logic/common/GlobalSnackbar.dart';
import '../../business_logic/provider/LoginCredentialsProvider.dart';
import '../../business_logic/provider/TokenProvider.dart';
// import '../../data/models/Requests/AuthenticateRequest.dart';
// import '../../data/models/Responses/AuthenticateResponse.dart';
// import '../../data/service/AuthenticationService.dart';
import '../constants/QColor.dart';
import '../constants/QPadding.dart';
import '../constants/QString.dart';
import 'Home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  // AuthenticationService? authenticationService;

  String? UserName;
  String? Password;

  @override
  void initState() {
    super.initState();
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
        title: Text(QString.titleLogin),
        backgroundColor: QColor.globalAppBarColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                QPadding.globalPaddingLeft,
                QPadding.globalPaddingTop,
                QPadding.globalPaddingRight,
                QPadding.globalPaddingBottom),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  widgetUserName(),
                  widgetPassword(),
                  widgetSubmit(),
                ],
              ),
            )),
      ),
    );
  }


  Widget widgetUserName() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalInputFieldLeft,
                QPadding.globalInputFieldTop,
                QPadding.globalInputFieldRight,
                QPadding.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(),
                  labelText: 'User Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (value) {
                UserName = value;
              },
            )),
      ],
    );
  }

  Widget widgetPassword() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalInputFieldLeft,
                QPadding.globalInputFieldTop,
                QPadding.globalInputFieldRight,
                QPadding.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (value) {
                Password = value;
              },
            )),
      ],
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                QPadding.globalInputFieldLeft,
                QPadding.globalInputFieldTop,
                QPadding.globalInputFieldRight,
                QPadding.globalInputFieldBottom),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: QColor.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text('Submit'),
              onPressed: () {Get.to(Home());},
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onPressedSubmitButton() async {

    // Navigator.pushNamed(context, '/Home');
    // if (!formKey.currentState.validate()) {
    //   return;
    // }
    // formKey.currentState.save();

    // Navigator.pop(context);
    // Navigator.pushNamed(context, '/Home');

    //   GlobalProgressDialog dialog = GlobalProgressDialog(context);
    //   dialog.showSimpleFontellicoProgressDialog(false, QString.dialogLoading,
    //       SimpleFontelicoProgressDialogType.hurricane);
    //
    //   AuthenticationService authenticationService = AuthenticationService();
    //   AuthenticateResponse authenticateResponse =
    //       await authenticationService.authenticateLogin(AuthenticateLoginRequest(
    //           UserName: 'basit@gmail.com', Password: 'basit'));
    //   if (authenticateResponse != null) {
    //     if (authenticateResponse.isSuccess) {
    //       context.read<TokenProvider>().setToken(authenticateResponse.token);
    //       context.read<TokenProvider>().setLoginSample(authenticateResponse.data);
    //       context.read<LoginCredentialsProvider>().setLoginCredentials(
    //           AuthenticateLoginRequest(
    //               UserName: 'basit@gmail.com', Password: 'basit'));
    //       dialog.hideSimpleFontellicoProgressDialog();
    //       Navigator.pop(context);
    //       Navigator.pushNamed(context, '/Home');
    //     } else {
    //       GlobalSnackbar.showMessageUsingSnackBar(
    //           QColor.snackGlobalFailed, authenticateResponse.message, context);
    //     }
    //   } else {
    //     GlobalSnackbar.showMessageUsingSnackBar(
    //         QColor.snackGlobalFailed, 'Failed', context);
    //   }
    //   dialog.hideSimpleFontellicoProgressDialog();
    // }
  }
}