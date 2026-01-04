import 'package:get/get.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../core/errors/failures.dart';

class TaskController extends GetxController {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskController({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  });

  final RxList<Task> tasks = <Task>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getTasks();
    result.fold(
      (failure) {
        errorMessage.value = _mapFailureToMessage(failure);
        tasks.clear();
      },
      (taskList) {
        tasks.value = taskList;
        errorMessage.value = '';
      },
    );
    
    isLoading.value = false;
  }

  Future<void> addTask(String title, String description) async {
    if (title.trim().isEmpty) {
      errorMessage.value = 'Title cannot be empty';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final newTask = Task(
      id: 0, // Will be assigned by the backend
      title: title.trim(),
      description: description.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    final result = await createTask(newTask);
    result.fold(
      (failure) {
        errorMessage.value = _mapFailureToMessage(failure);
      },
      (createdTask) {
        tasks.insert(0, createdTask);
        errorMessage.value = '';
        Get.back(); // Close the add task dialog/page
        Get.snackbar('Success', 'Task created successfully');
      },
    );

    isLoading.value = false;
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      updatedAt: DateTime.now(),
    );

    final result = await updateTask(updatedTask);
    result.fold(
      (failure) {
        errorMessage.value = _mapFailureToMessage(failure);
        Get.snackbar('Error', 'Failed to update task');
      },
      (updated) {
        final index = tasks.indexWhere((t) => t.id == updated.id);
        if (index != -1) {
          tasks[index] = updated;
        }
        Get.snackbar('Success', 'Task updated successfully');
      },
    );
  }

  Future<void> updateTaskDetails(Task task, String title, String description) async {
    if (title.trim().isEmpty) {
      errorMessage.value = 'Title cannot be empty';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final updatedTask = task.copyWith(
      title: title.trim(),
      description: description.trim(),
      updatedAt: DateTime.now(),
    );

    final result = await updateTask(updatedTask);
    result.fold(
      (failure) {
        errorMessage.value = _mapFailureToMessage(failure);
        Get.snackbar('Error', 'Failed to update task');
      },
      (updated) {
        final index = tasks.indexWhere((t) => t.id == updated.id);
        if (index != -1) {
          tasks[index] = updated;
        }
        errorMessage.value = '';
        Get.back();
        Get.snackbar('Success', 'Task updated successfully');
      },
    );

    isLoading.value = false;
  }

  Future<void> removeTask(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await deleteTask(id);
    result.fold(
      (failure) {
        errorMessage.value = _mapFailureToMessage(failure);
        Get.snackbar('Error', 'Failed to delete task');
      },
      (_) {
        tasks.removeWhere((task) => task.id == id);
        errorMessage.value = '';
        Get.snackbar('Success', 'Task deleted successfully');
      },
    );

    isLoading.value = false;
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'Network error: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Cache error: ${failure.message}';
    } else {
      return 'An unexpected error occurred';
    }
  }

  List<Task> get completedTasks => tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks => tasks.where((task) => !task.isCompleted).toList();
}

