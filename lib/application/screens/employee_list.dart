import 'package:flutter/material.dart';

import '../../../data/models/employee_model.dart';
import '../../domain/usecase/helper_services/http_service.dart';
import 'employee_details.dart';
import 'employee_search.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Data>> _futureEmployees;
  List<Data> _allEmployees = [];
  List<Data> _filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    _futureEmployees = EmployeeService().getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Data>>(
        future: _futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employees found'));
          } else {
            _allEmployees = snapshot.data!;
            _filteredEmployees = _allEmployees;
            return ListView.builder(
              itemCount: _filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee = _filteredEmployees[index];
                return ListTile(
                  title: Text(employee.employeeName ?? 'No Name'),
                  leading: CircleAvatar(
                    child: employee.profileImage != null &&
                            employee.profileImage!.length > 10
                        ? Image.network(employee.profileImage!)
                        : const Icon(Icons.person),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EmployeeDetailsScreen(employee: employee),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
