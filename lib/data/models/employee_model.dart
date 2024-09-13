// models.dart
class Employee {
  String? status;
  List<Data>? data;
  String? message;

  Employee({this.status, this.data, this.message});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      status: json['status'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Data.fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
      'message': message,
    };
  }
}

class Data {
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;
  String? profileImage;

  Data({
    this.id,
    this.employeeName,
    this.employeeSalary,
    this.employeeAge,
    this.profileImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      employeeName: json['employee_name'],
      employeeSalary: json['employee_salary'],
      employeeAge: json['employee_age'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_name': employeeName,
      'employee_salary': employeeSalary,
      'employee_age': employeeAge,
      'profile_image': profileImage,
    };
  }
}
