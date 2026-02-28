import '../entities/department.dart';
import '../repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class GetAllDepartments {
  final EmployeeRepository repository;

  GetAllDepartments(this.repository);

  Future<Either<Failure, List<Department>>> call() async {
    return await repository.getAllDepartments();
  }
}

