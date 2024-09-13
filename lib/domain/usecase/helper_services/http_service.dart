import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../data/models/employee_model.dart';
import 'helper_service.dart';

class EmployeeService {
  final String _baseUrl = 'https://dummy.restapiexample.com/api/v1/employees';

  Future<void> fetchAndStoreEmployees() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        try {
          log(response.body);
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          final Employee employeeData = Employee.fromJson(jsonResponse);
          final List<Data> employees = employeeData.data ?? [];
          await DatabaseHelper().insertEmployees(employees);
        } catch (e) {
          throw Exception('Failed to parse employee data: $e');
        }
      } else {
        throw Exception(
            'Failed to load employees. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching and storing data: $e');
    }
  }

  Future<List<Data>> getEmployees() async {
    try {
      return await DatabaseHelper().getEmployees();
    } catch (e) {
      print('Error retrieving employees from database: $e');
      return [];
    }
  }
}
