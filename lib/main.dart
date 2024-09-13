// main.dart
import 'package:flutter/material.dart';

import 'application/screens/employee_list.dart';
import 'domain/usecase/helper_services/http_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EmployeeService().fetchAndStoreEmployees();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EmployeeListScreen(),
    );
  }
}
