import '../entities/employee.dart';
import '../repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class UpdateEmployee {
  final EmployeeRepository repository;

  UpdateEmployee(this.repository);

  Future<Either<Failure, Employee>> call(String departmentId, String employeeId, Employee employee) async {
    return await repository.updateEmployee(departmentId, employeeId, employee);
  }
}

