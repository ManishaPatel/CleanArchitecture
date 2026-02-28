import '../../domain/entities/department.dart';
import 'employee_model.dart';

class DepartmentModel extends Department {
  const DepartmentModel({
    required super.id,
    required super.name,
    required super.location,
    super.employees = const [],
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String? ?? '',
      employees: (json['employees'] as List<dynamic>?)
              ?.map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'employees': employees.map((e) => (e as EmployeeModel).toJson()).toList(),
    };
  }
}

