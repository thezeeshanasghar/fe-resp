import 'dart:convert';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Expense.dart';
//import 'package:baby_doctor/Models/Request/EmployeeModel.dart';
import 'package:http/http.dart' as http;
//import '../Models/Employee.dart';

class ExpenseService {

  Future<List<Expense>> getExpenses() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Expense>((json) => Expense.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load Employee');
    }
  }

  Future<Expense> getExpenseById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Expense/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse= jsonDecode(response.body);
      return Expense.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Procedure');
    }
  }
  Future<bool> InsertExpense(Expense expense) async {

    // Map<String, dynamic> Obj = {
    //
    // };
    final response =
    await http.post(Uri.https(Strings.pathAPI, 'api/Expense'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(expense));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> UpdateInvoice(Expense expense) async {
    final response = await http.put(
        Uri.https(Strings.pathAPI, 'api/Invoice/${expense.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(expense.toJson()));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeleteExpense(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/expense/${id}'),
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
