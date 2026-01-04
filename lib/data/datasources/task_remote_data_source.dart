import 'package:http/http.dart' as http;
import '../../core/errors/failures.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTaskById(int id);
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSourceImpl({required this.client});

  // Mock data storage (simulating API)
  static List<TaskModel> _mockTasks = [
    TaskModel(
      id: 1,
      title: 'Complete Flutter Clean Architecture',
      description: 'Build a task manager app with clean architecture',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    TaskModel(
      id: 2,
      title: 'Write Unit Tests',
      description: 'Add comprehensive unit tests for all layers',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TaskModel(
      id: 3,
      title: 'Update Documentation',
      description: 'Create README with features and setup instructions',
      isCompleted: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Future<List<TaskModel>> getTasks() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, you would make an HTTP request here:
    // final response = await client.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tasksEndpoint}'));
    // if (response.statusCode == 200) {
    //   return (json.decode(response.body) as List)
    //       .map((task) => TaskModel.fromJson(task))
    //       .toList();
    // } else {
    //   throw ServerFailure('Failed to load tasks');
    // }
    
    return List.from(_mockTasks);
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      final task = _mockTasks.firstWhere((task) => task.id == id);
      return task;
    } catch (e) {
      throw ServerFailure('Task not found');
    }
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final newTask = TaskModel(
      id: _mockTasks.isEmpty ? 1 : _mockTasks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: DateTime.now(),
    );
    
    _mockTasks.add(newTask);
    return newTask;
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final index = _mockTasks.indexWhere((t) => t.id == task.id);
    if (index == -1) {
      throw ServerFailure('Task not found');
    }
    
    final updatedTask = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );
    
    _mockTasks[index] = updatedTask;
    return updatedTask;
  }

  @override
  Future<void> deleteTask(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _mockTasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      throw ServerFailure('Task not found');
    }
    
    _mockTasks.removeAt(index);
  }
}

