import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class GetTaskById {
  final TaskRepository repository;

  GetTaskById(this.repository);

  Future<Either<Failure, Task>> call(int id) async {
    return await repository.getTaskById(id);
  }
}

