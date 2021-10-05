import 'dart:convert';
import 'package:baby_receptionist/data/models/Responses/DoctorResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DoctorService {
  Future<DoctorResponseList> getDoctors({@required String token}) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, QString.apiDoctorGet),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<DoctorResponse> getDoctorById(
      {@required int id, @required String token}) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, '${QString.apiDoctorGet}/$id'),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
