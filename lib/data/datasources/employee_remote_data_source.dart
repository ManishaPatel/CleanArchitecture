import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/errors/failures.dart';
import '../models/employee_model.dart';
import '../models/department_model.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<EmployeeModel>> getAllEmployees();
  Future<List<DepartmentModel>> getAllDepartments();
  Future<List<EmployeeModel>> getEmployeesByDepartment(String departmentId);
  Future<EmployeeModel> addEmployeeToDepartment(String departmentId, EmployeeModel employee);
  Future<EmployeeModel> updateEmployee(String departmentId, String employeeId, EmployeeModel employee);
  Future<void> deleteEmployee(String departmentId, String employeeId);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final http.Client client;

  EmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EmployeeModel>> getAllEmployees() async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.employeesEndpoint}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw ServerFailure('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API is not available
      return _getMockEmployees();
    }
  }

  @override
  Future<List<DepartmentModel>> getAllDepartments() async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.departmentsEndpoint}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => DepartmentModel.fromJson(json)).toList();
      } else {
        throw ServerFailure('Failed to load departments: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API is not available
      return _getMockDepartments();
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployeesByDepartment(String departmentId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.employeesByDepartmentEndpoint(departmentId)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw ServerFailure('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data
      return _getMockEmployees().where((e) => e.departmentId == departmentId).toList();
    }
  }

  @override
  Future<EmployeeModel> addEmployeeToDepartment(String departmentId, EmployeeModel employee) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addEmployeeEndpoint(departmentId)}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(employee.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return EmployeeModel.fromJson(json.decode(response.body));
      } else {
        throw ServerFailure('Failed to add employee: ${response.statusCode}');
      }
    } catch (e) {
      // For demo, return the employee with generated ID
      return EmployeeModel(
        id: 'emp${DateTime.now().millisecondsSinceEpoch}',
        name: employee.name,
        email: employee.email,
        position: employee.position,
        salary: employee.salary,
        departmentId: departmentId,
      );
    }
  }

  @override
  Future<EmployeeModel> updateEmployee(String departmentId, String employeeId, EmployeeModel employee) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateEmployeeEndpoint(departmentId, employeeId)}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(employee.toJson()),
      );

      if (response.statusCode == 200) {
        return EmployeeModel.fromJson(json.decode(response.body));
      } else {
        throw ServerFailure('Failed to update employee: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to update employee: $e');
    }
  }

  @override
  Future<void> deleteEmployee(String departmentId, String employeeId) async {
    try {
      final response = await client.delete(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.deleteEmployeeEndpoint(departmentId, employeeId)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw ServerFailure('Failed to delete employee: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to delete employee: $e');
    }
  }

  // Mock data for fallback
  List<EmployeeModel> _getMockEmployees() {
    return [
      EmployeeModel(
        id: 'emp001',
        name: 'Alice Smith',
        email: 'alice.smith@example.com',
        position: 'Recruiter',
        salary: 60000,
        departmentId: 'dept01',
      ),
      EmployeeModel(
        id: 'emp002',
        name: 'Bob Johnson',
        email: 'bob.johnson@example.com',
        position: 'Software Engineer',
        salary: 80000,
        departmentId: 'dept02',
      ),
      EmployeeModel(
        id: 'emp003',
        name: 'Charlie Brown',
        email: 'charlie.brown@example.com',
        position: 'HR Assistant',
        salary: 40000,
        departmentId: 'dept01',
      ),
      EmployeeModel(
        id: 'emp004',
        name: 'Diana Prince',
        email: 'diana.prince@example.com',
        position: 'System Architect',
        salary: 90000,
        departmentId: 'dept02',
      ),
    ];
  }

  List<DepartmentModel> _getMockDepartments() {
    final employees = _getMockEmployees();
    return [
      DepartmentModel(
        id: 'dept01',
        name: 'Human Resources',
        location: 'Building A',
        employees: employees.where((e) => e.departmentId == 'dept01').toList(),
      ),
      DepartmentModel(
        id: 'dept02',
        name: 'Engineering',
        location: 'Building B',
        employees: employees.where((e) => e.departmentId == 'dept02').toList(),
      ),
    ];
  }
}

