import 'dart:convert';
import 'package:baby_receptionist/data/models/Responses/ProcedureResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProcedureService {
  Future<ProcedureResponseList> getProcedures({@required String token}) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, QString.apiProcedureGet),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ProcedureResponse> getProcedureById(
      {@required int id, @required String token}) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, '${QString.apiProcedureGet}/$id'),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
