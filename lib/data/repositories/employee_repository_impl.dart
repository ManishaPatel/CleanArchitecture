import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/department.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_remote_data_source.dart';
import '../models/employee_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Employee>>> getAllEmployees() async {
    try {
      final employees = await remoteDataSource.getAllEmployees();
      return Either.right(employees);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Department>>> getAllDepartments() async {
    try {
      final departments = await remoteDataSource.getAllDepartments();
      return Either.right(departments);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Employee>>> getEmployeesByDepartment(String departmentId) async {
    try {
      final employees = await remoteDataSource.getEmployeesByDepartment(departmentId);
      return Either.right(employees);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Employee>> addEmployeeToDepartment(String departmentId, Employee employee) async {
    try {
      final employeeModel = EmployeeModel(
        id: employee.id,
        name: employee.name,
        email: employee.email,
        position: employee.position,
        salary: employee.salary,
        departmentId: departmentId,
      );
      final createdEmployee = await remoteDataSource.addEmployeeToDepartment(departmentId, employeeModel);
      return Either.right(createdEmployee);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Employee>> updateEmployee(String departmentId, String employeeId, Employee employee) async {
    try {
      final employeeModel = EmployeeModel(
        id: employeeId,
        name: employee.name,
        email: employee.email,
        position: employee.position,
        salary: employee.salary,
        departmentId: departmentId,
      );
      final updatedEmployee = await remoteDataSource.updateEmployee(departmentId, employeeId, employeeModel);
      return Either.right(updatedEmployee);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(String departmentId, String employeeId) async {
    try {
      await remoteDataSource.deleteEmployee(departmentId, employeeId);
      return Either.right(null);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }
}

