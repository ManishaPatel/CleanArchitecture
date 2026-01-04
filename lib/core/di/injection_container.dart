import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/task_remote_data_source.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/get_task_by_id.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../presentation/controllers/task_controller.dart';

void setupDependencyInjection() {
  // Data Sources
  Get.lazyPut<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(client: http.Client()),
  );

  // Repositories
  Get.lazyPut<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: Get.find<TaskRemoteDataSource>(),
    ),
  );

  // Use Cases
  Get.lazyPut(() => GetTasks(Get.find<TaskRepository>()));
  Get.lazyPut(() => GetTaskById(Get.find<TaskRepository>()));
  Get.lazyPut(() => CreateTask(Get.find<TaskRepository>()));
  Get.lazyPut(() => UpdateTask(Get.find<TaskRepository>()));
  Get.lazyPut(() => DeleteTask(Get.find<TaskRepository>()));

  // Controllers
  Get.lazyPut(
    () => TaskController(
      getTasks: Get.find<GetTasks>(),
      createTask: Get.find<CreateTask>(),
      updateTask: Get.find<UpdateTask>(),
      deleteTask: Get.find<DeleteTask>(),
    ),
  );
}

