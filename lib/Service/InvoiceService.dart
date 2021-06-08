import 'dart:convert';
import 'package:baby_receptionist/Model/Invoice.dart';
import 'package:baby_receptionist/Model/Patient.dart';
import 'package:baby_receptionist/Model/PatientInvoice.dart';

import 'package:http/http.dart' as http;

class InvoiceService {
  Future<List<Invoice>> getPatient() async {
    final response =
        await http.get(Uri.https('babymedics.fernflowers.com', 'api/Invoice'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Invoice>((json) => Invoice.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Invoice');
    }
  }

  Future<Invoice> getInvoiceById(int Id) async {
    final response = await http
        .get(Uri.https('babymedics.fernflowers.com', 'api/Invoice/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse = jsonDecode(response.body);
      return Invoice.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Patient');
    }
  }

  // Future<bool> InsertPatient(Patient patients) async {
  //   print(patients);
  //   Map<String, dynamic> Obj = {
  //     "name": patients.name,
  //     "sex": patients.sex,
  //     "address": patients.address,
  //     "fatherHusbandName": patients.fatherHusbandName,
  //     "email": patients.email,
  //     "city": patients.city,
  //     "localArea": patients.localArea,
  //     "dob": patients.dob,
  //     "contact": patients.contact,
  //     "patientDetails": patients.patientDetails,
  //     "placeofBirth": patients.placeofBirth,
  //     "patientCategory": patients.patientCategory,
  //     "maritalStatus": patients.maritalStatus,
  //     "patientType": patients.patientType,
  //     "externalId": patients.externalId,
  //     "bloodGroup": patients.bloodGroup,
  //     "clinicSite": patients.clinicSite,
  //     "referedBy": patients.referedBy,
  //     "referedDate": patients.referedDate,
  //     "religion": patients.religion,
  //     "patientGardian": patients.patientGardian,
  //     "paymentProfile": patients.paymentProfile,
  //   };
  //   final response = await http.post(Uri.https('babymedics.fernflowers.com', 'api/Patient'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(Obj));
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> UpdatePatient(Patient patients) async {
  //   final response = await http.put(
  //       Uri.https('babymedics.fernflowers.com', 'api/Patient/${patients.id}'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(patients.toJson()));
  //   if (response.statusCode == 204) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> DeletePatient(int id) async {
    final response = await http.delete(
        Uri.https('babymedics.fernflowers.com', 'api/Patient/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
