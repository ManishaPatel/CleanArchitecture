import 'package:equatable/equatable.dart';
import 'employee.dart';

class Department extends Equatable {
  final String id;
  final String name;
  final String location;
  final List<Employee> employees;

  const Department({
    required this.id,
    required this.name,
    required this.location,
    this.employees = const [],
  });

  @override
  List<Object> get props => [id, name, location, employees];
}

