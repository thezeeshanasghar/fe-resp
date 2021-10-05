import 'package:baby_receptionist/business_logic/common/GlobalProgressDialog.dart';
import 'package:baby_receptionist/business_logic/common/GlobalSnackbar.dart';
import 'package:baby_receptionist/business_logic/provider/LoginCredentialsProvider.dart';
import 'package:baby_receptionist/business_logic/provider/TokenProvider.dart';
import 'package:baby_receptionist/data/models/Requests/AuthenticateRequest.dart';
import 'package:baby_receptionist/data/models/Responses/AuthenticateResponse.dart';
import 'package:baby_receptionist/data/service/AuthenticationService.dart';
import 'package:baby_receptionist/presentation/constants/QColor.dart';
import 'package:baby_receptionist/presentation/constants/QPadding.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  AuthenticationService authenticationService;

  String UserName;
  String Password;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
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
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: viewportConstraints.minHeight,
                    minWidth: viewportConstraints.minWidth),
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
          },
        ),
      ),
    );
  }

  void initVariablesAndClasses() {
    authenticationService = AuthenticationService();
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
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
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
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
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
              onPressed: () => onPressedSubmitButton(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onPressedSubmitButton() async {
    // if (!formKey.currentState.validate()) {
    //   return;
    // }
    // formKey.currentState.save();

    // Navigator.pop(context);
    // Navigator.pushNamed(context, '/Home');

    GlobalProgressDialog dialog = GlobalProgressDialog(context);
    dialog.showSimpleFontellicoProgressDialog(false, QString.dialogLoading,
        SimpleFontelicoProgressDialogType.hurricane);

    AuthenticationService authenticationService = AuthenticationService();
    AuthenticateResponse authenticateResponse =
        await authenticationService.authenticateLogin(AuthenticateLoginRequest(
            UserName: 'basit@gmail.com', Password: 'basit'));
    if (authenticateResponse != null) {
      if (authenticateResponse.isSuccess) {
        context.read<TokenProvider>().setToken(authenticateResponse.token);
        context.read<TokenProvider>().setLoginSample(authenticateResponse.data);
        context.read<LoginCredentialsProvider>().setLoginCredentials(
            AuthenticateLoginRequest(
                UserName: 'basit@gmail.com', Password: 'basit'));
        dialog.hideSimpleFontellicoProgressDialog();
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Home');
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            QColor.snackGlobalFailed, authenticateResponse.message, context);
      }
    } else {
      GlobalSnackbar.showMessageUsingSnackBar(
          QColor.snackGlobalFailed, 'Failed', context);
    }
    dialog.hideSimpleFontellicoProgressDialog();
  }
}
