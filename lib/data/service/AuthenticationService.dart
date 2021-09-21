import 'dart:convert';
import 'package:baby_receptionist/data/models/Requests/AuthenticateRequest.dart';
import 'package:baby_receptionist/data/models/Responses/AuthenticateResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<AuthenticateResponse> authenticateLogin(AuthenticateLoginRequest loginRequest) async {
    final response = await http.post(Uri.https(QString.pathAPI, QString.apiAuthenticationLogin),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
        },
        body: jsonEncode(loginRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AuthenticateResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AuthenticateResponse> authenticateRefresh(AuthenticateRefreshRequest refreshRequest) async {
    final response = await http.post(Uri.https(QString.pathAPI, QString.apiAuthenticationRefresh),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
        },
        body: jsonEncode(refreshRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AuthenticateResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
