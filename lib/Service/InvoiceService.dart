import 'dart:convert';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Invoice.dart';
import 'package:baby_receptionist/Model/Patient.dart';
import 'package:baby_receptionist/Model/PatientInvoice.dart';

import 'package:http/http.dart' as http;

class InvoiceService {
  Future<List<Invoice>> getPatient() async {
    final response =
        await http.get(Uri.https(Strings.pathAPI, 'api/Invoice'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Invoice>((json) => Invoice.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Invoice');
    }
  }

  Future<Invoice> getInvoiceById(int Id) async {
    final response = await http
        .get(Uri.https(Strings.pathAPI, 'api/Invoice/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse = jsonDecode(response.body);
      return Invoice.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Patient');
    }
  }

  Future<bool> InsertInvoice(InvoiceData invoiceData) async {
    print(invoiceData);
    Map<String, dynamic> Obj = {
      "PreviousVisitDate": invoiceData.PreviousVisitDate,
      "TodayVisitDate": invoiceData.TodayVisitDate,
      "PaymentType": invoiceData.PaymentType,
      "ConsultationFee": invoiceData.ConsultationFee,
      "Discount": invoiceData.Discount,
      "NetAmount": invoiceData.NetAmount,
      "Disposibles": invoiceData.Disposibles,
      "GrossAmount": invoiceData.GrossAmount,
      "IsRefund": invoiceData.IsRefund,
      "RefundAmount": invoiceData.RefundAmount,
    };
    final response = await http.post(Uri.https(Strings.pathAPI, 'api/Invoice/insert'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> UpdatePatient(InvoiceData invoiceData) async {
    final response = await http.put(
        Uri.https(Strings.pathAPI, 'api/Patient/${invoiceData.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(invoiceData.toJson()));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeletePatient(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/Patient/${id}'),
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
