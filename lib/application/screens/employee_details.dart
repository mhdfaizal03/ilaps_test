import 'package:flutter/material.dart';

import '../../data/models/employee_model.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Data employee;

  const EmployeeDetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                child: employee.profileImage != null &&
                        employee.profileImage!.length > 10
                    ? Image.network(employee.profileImage.toString())
                    : const Icon(Icons.person, size: 100),
              ),
              const SizedBox(height: 16.0),
              Text(
                employee.employeeName ?? 'No Name',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text('Salary: ${employee.employeeSalary ?? 'N/A'}'),
              Text('Age: ${employee.employeeAge ?? 'N/A'}'),
            ],
          ),
        ),
      ),
    );
  }
}
