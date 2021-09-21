import 'dart:convert';
import 'package:baby_receptionist/data/models/Requests/AppointmentRequest.dart';
import 'package:baby_receptionist/data/models/Responses/AppointmentResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  Future<AppointmentResponseList> getAppointments(String token) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, QString.apiAppointmentGet),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AppointmentResponseList> getAppointmentByCategory(
      {@required String token, @required String category}) async {
    final response = await http.get(
      Uri.https(
          QString.pathAPI, '${QString.apiAppointmentGetByCategory}/$category'),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AppointmentResponseList> searchAppointmentsUsingPost(
      {@required String token,
      @required AppointmentSearchRequest request}) async {
    final response = await http.post(
        Uri.https(QString.pathAPI, QString.apiAppointmentPostSearch),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
          QString.apiAuthorization: '${QString.apiBearer} $token',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }
}
