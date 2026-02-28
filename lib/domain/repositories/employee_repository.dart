import '../entities/employee.dart';
import '../entities/department.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getAllEmployees();
  Future<Either<Failure, List<Department>>> getAllDepartments();
  Future<Either<Failure, List<Employee>>> getEmployeesByDepartment(String departmentId);
  Future<Either<Failure, Employee>> addEmployeeToDepartment(String departmentId, Employee employee);
  Future<Either<Failure, Employee>> updateEmployee(String departmentId, String employeeId, Employee employee);
  Future<Either<Failure, void>> deleteEmployee(String departmentId, String employeeId);
}

