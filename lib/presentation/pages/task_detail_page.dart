import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/responsive.dart';
import '../../domain/entities/task.dart';
import '../controllers/task_controller.dart';
import 'edit_task_page.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();
    final currentTask = controller.tasks.firstWhereOrNull((t) => t.id == task.id) ?? task;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Get.to(() => EditTaskPage(task: currentTask)),
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: currentTask.isCompleted ? Colors.green[100] : Colors.orange[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    currentTask.isCompleted ? Icons.check_circle : Icons.pending,
                    size: 16,
                    color: currentTask.isCompleted ? Colors.green[700] : Colors.orange[700],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    currentTask.isCompleted ? 'Completed' : 'Pending',
                    style: TextStyle(
                      color: currentTask.isCompleted ? Colors.green[700] : Colors.orange[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              'Title',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentTask.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Description
            Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentTask.description.isEmpty
                  ? 'No description provided'
                  : currentTask.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 32),
            // Dates
            _InfoRow(
              icon: Icons.calendar_today,
              label: 'Created',
              value: _formatDate(currentTask.createdAt),
            ),
            if (currentTask.updatedAt != null) ...[
              const SizedBox(height: 12),
              _InfoRow(
                icon: Icons.update,
                label: 'Last Updated',
                value: _formatDate(currentTask.updatedAt!),
              ),
            ],
            const SizedBox(height: 32),
            // Actions
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.toggleTaskCompletion(currentTask),
                    icon: Icon(
                      currentTask.isCompleted ? Icons.undo : Icons.check,
                    ),
                    label: Text(
                      currentTask.isCompleted ? 'Mark as Pending' : 'Mark as Completed',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: currentTask.isCompleted
                          ? Colors.orange
                          : Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Delete Task'),
                                content: const Text(
                                    'Are you sure you want to delete this task? This action cannot be undone.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.removeTask(currentTask.id);
                                      Get.back(); // Close detail page
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete Task'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.red,
                    ),
                  ),
                )),
          ],
        ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

