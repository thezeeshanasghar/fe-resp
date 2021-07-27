import 'dart:convert';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Model/Expense.dart';
//import 'package:baby_doctor/Models/Request/EmployeeModel.dart';
import 'package:http/http.dart' as http;
//import '../Models/Employee.dart';

class ExpenseService {

  Future<Expense> getExpenses() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Expense/get'));
    final jsonResponse = jsonDecode(response.body);
    return Expense.fromJson(jsonResponse);
  }

  Future<Expense> getExpenseById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Expense/get/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse= jsonDecode(response.body);
      return Expense.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Procedure');
    }
  }
  Future<bool> InsertExpense(PatientExpense expense) async {

    // Map<String, dynamic> Obj = {
    //
    // };
    final response =
    await http.post(Uri.https(Strings.pathAPI, 'api/Expense/insert'),
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

  Future<bool> UpdateExpense(PatientExpense expense) async {
    final response = await http.put(
        Uri.https(Strings.pathAPI, 'api/Expense/update/${expense.id}'),
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
        Uri.https(Strings.pathAPI, 'api/expense/delete/${id}'),
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
