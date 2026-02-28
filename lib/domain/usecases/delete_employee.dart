import '../repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class DeleteEmployee {
  final EmployeeRepository repository;

  DeleteEmployee(this.repository);

  Future<Either<Failure, void>> call(String departmentId, String employeeId) async {
    return await repository.deleteEmployee(departmentId, employeeId);
  }
}

