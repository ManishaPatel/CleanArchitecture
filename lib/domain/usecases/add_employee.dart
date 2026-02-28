import '../entities/employee.dart';
import '../repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class AddEmployee {
  final EmployeeRepository repository;

  AddEmployee(this.repository);

  Future<Either<Failure, Employee>> call(String departmentId, Employee employee) async {
    return await repository.addEmployeeToDepartment(departmentId, employee);
  }
}

