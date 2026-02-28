import '../entities/employee.dart';
import '../repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class GetAllEmployees {
  final EmployeeRepository repository;

  GetAllEmployees(this.repository);

  Future<Either<Failure, List<Employee>>> call() async {
    return await repository.getAllEmployees();
  }
}

