import 'dart:convert';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Doctor.dart';
import 'package:http/http.dart' as http;

class DoctorService {

  Future<Doctor> getDoctor() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor/get'));
    final jsonResponse = jsonDecode(response.body);
    return Doctor.fromJson(jsonResponse);
  }

  Future<Doctor> getDoctorById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor/get/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse= jsonDecode(response.body);
      return Doctor.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Procedure');
    }
  }

}
