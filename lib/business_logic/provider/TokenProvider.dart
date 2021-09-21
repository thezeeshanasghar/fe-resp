import 'package:baby_receptionist/data/models/Sample/LoginSample.dart';
import 'package:baby_receptionist/data/models/Sample/TokenSample.dart';
import 'package:flutter/foundation.dart';

class TokenProvider with ChangeNotifier {
  TokenSample _tokenSample = TokenSample();
  LoginSample _loginSample = LoginSample();

  TokenSample get tokenSample => _tokenSample;

  LoginSample get loginSample => _loginSample;

  void setToken(TokenSample sample) {
    this._tokenSample = sample;
    notifyListeners();
  }

  void setLoginSample(LoginSample loginSample) {
    this._loginSample = loginSample;
    notifyListeners();
  }
}
