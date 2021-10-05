import 'dart:convert';
import 'package:baby_receptionist/data/models/Requests/InvoiceRequest.dart';
import 'package:baby_receptionist/data/models/Responses/InvoiceResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvoiceService {
  Future<InvoiceResponseList> searchInvoicesUsingPost(
      {@required InvoiceSearchRequest invoiceSearchRequest,
      @required String token}) async {
    final response = await http.post(
        Uri.https(QString.pathAPI, QString.apiInvoicePostSearch),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
          QString.apiAuthorization: '${QString.apiBearer} $token',
        },
        body: jsonEncode(invoiceSearchRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<InvoiceResponse> insertInvoice(
      AddInvoiceRequest invoiceRequest, String token) async {
    final response =
        await http.post(Uri.https(QString.pathAPI, QString.apiInvoiceInsert),
            headers: <String, String>{
              QString.apiContentType: QString.apiApplicationJson,
              QString.apiAuthorization: '${QString.apiBearer} $token',
            },
            body: jsonEncode(invoiceRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
