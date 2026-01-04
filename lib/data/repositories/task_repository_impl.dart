import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final tasks = await remoteDataSource.getTasks();
      return Either.right(tasks.map((model) => model.toEntity()).toList());
    } on ServerFailure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> getTaskById(int id) async {
    try {
      final task = await remoteDataSource.getTaskById(id);
      return Either.right(task.toEntity());
    } on ServerFailure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final createdTask = await remoteDataSource.createTask(taskModel);
      return Either.right(createdTask.toEntity());
    } on ServerFailure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTask = await remoteDataSource.updateTask(taskModel);
      return Either.right(updatedTask.toEntity());
    } on ServerFailure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      await remoteDataSource.deleteTask(id);
      return Either.right(null);
    } on ServerFailure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(ServerFailure(e.toString()));
    }
  }
}

