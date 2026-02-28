import '../entities/employee.dart';
import '../repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class GetEmployeesByDepartment {
  final EmployeeRepository repository;

  GetEmployeesByDepartment(this.repository);

  Future<Either<Failure, List<Employee>>> call(String departmentId) async {
    return await repository.getEmployeesByDepartment(departmentId);
  }
}

