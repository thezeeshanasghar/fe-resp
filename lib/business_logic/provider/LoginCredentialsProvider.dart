import 'package:baby_receptionist/data/models/Requests/AuthenticateRequest.dart';
import 'package:flutter/material.dart';

class LoginCredentialsProvider with ChangeNotifier {
  AuthenticateLoginRequest loginRequest = AuthenticateLoginRequest();

  AuthenticateLoginRequest get authenticateLoginRequest => loginRequest;

  void setLoginCredentials(AuthenticateLoginRequest loginRequest) {
    this.loginRequest = loginRequest;
    notifyListeners();
  }
}
