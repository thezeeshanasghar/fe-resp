import 'dart:convert';
import 'package:baby_receptionist/data/models/Requests/ExpenseRequest.dart';
import 'package:baby_receptionist/data/models/Responses/ExpenseResponse.dart';
import 'package:baby_receptionist/presentation/constants/QString.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ExpenseService {
  Future<ExpenseResponseList> getExpenses(String token) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, QString.apiExpenseGet),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponseList> searchExpense(
      {@required String search, @required String token}) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, '${QString.apiExpenseSearch}/$search'),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> getExpenseById(int id, String token) async {
    final response = await http.get(
      Uri.https(QString.pathAPI, '${QString.apiExpenseGet}/$id'),
      headers: <String, String>{
        QString.apiContentType: QString.apiApplicationJson,
        QString.apiAuthorization: '${QString.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> insertExpense(
      ExpenseRequest expenseRequest, String token) async {
    final response =
        await http.post(Uri.https(QString.pathAPI, QString.apiExpenseInsert),
            headers: <String, String>{
              QString.apiContentType: QString.apiApplicationJson,
              QString.apiAuthorization: '${QString.apiBearer} $token',
            },
            body: jsonEncode(expenseRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> updateExpense(
      ExpenseRequest expenseRequest, String token) async {
    final response = await http.put(
        Uri.https(QString.pathAPI,
            '${QString.apiExpenseUpdate}/${expenseRequest.id}'),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
          QString.apiAuthorization: '${QString.apiBearer} $token',
        },
        body: jsonEncode(expenseRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> deleteExpense(int id, String token) async {
    final response = await http.delete(
        Uri.https(QString.pathAPI, '${QString.apiExpenseDelete}/$id'),
        headers: <String, String>{
          QString.apiContentType: QString.apiApplicationJson,
          QString.apiAuthorization: '${QString.apiBearer} $token',
        });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
