import 'dart:convert';
import 'package:baby_receptionist/data/models/Requests/PatientRequest.dart';
import 'package:baby_receptionist/data/models/Responses/PatientResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:http/http.dart' as http;

class PatientService {
  Future<PatientResponseList> getPatients(String token) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, QString.apiPatientGet),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> getPatientById(int id, String token) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, '${QString.apiPatientGet}/$id'),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> insertPatient(PatientRequest patientRequest, String token) async {
    final response = await http.post(Uri.https(QString.pathAPI, QString.apiPatientInsert),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
          QString.apiAuthorization: '${QString.apiBearer} $token',
        },
        body: jsonEncode(patientRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> updatePatient(PatientRequest patientRequest, String token) async {
    final response = await http.put(Uri.https(QString.pathAPI, '${QString.apiPatientUpdate}/${patientRequest.id}'),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
          QString.apiAuthorization: '${QString.apiBearer} $token',
        },
        body: jsonEncode(patientRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> deletePatient(int id, String token) async {
    final response =
        await http.delete(Uri.https(QString.pathAPI, '${QString.apiPatientDelete}/$id'), headers: <String, String>{
      QString.apiContentType: QString.apiApplicationJson,
      QString.apiAuthorization: '${QString.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
