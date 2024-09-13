import 'package:employee_app/application/screens/employee_details.dart';
import 'package:flutter/material.dart';

import '../../../data/models/employee_model.dart';
import '../../domain/usecase/helper_services/http_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Data> _allEmployees = [];
  List<Data> _filteredEmployees = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
    _searchController.addListener(() {
      _filterEmployees();
    });
  }

  Future<void> _fetchEmployees() async {
    try {
      final employees = await EmployeeService().getEmployees();
      setState(() {
        _allEmployees = employees;
        _filteredEmployees = employees;
      });
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  void _filterEmployees() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEmployees = _allEmployees.where((employee) {
        return employee.employeeName?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Employees'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                hintText: 'Search by name...',
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredEmployees.isEmpty
                ? const Center(child: Text('No employees found'))
                : ListView.builder(
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
                  ),
          ),
        ],
      ),
    );
  }
}
