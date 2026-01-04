import '../repositories/task_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteTask(id);
  }
}

