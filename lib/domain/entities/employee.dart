import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String email;
  final String position;
  final double salary;
  final String departmentId;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.salary,
    required this.departmentId,
  });

  @override
  List<Object> get props => [id, name, email, position, salary, departmentId];
}

