import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.email,
    required super.position,
    required super.salary,
    required super.departmentId,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      position: json['position'] as String? ?? '',
      salary: (json['salary'] as num).toDouble(),
      departmentId: json['departmentId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'position': position,
      'salary': salary,
      'departmentId': departmentId,
    };
  }
}

