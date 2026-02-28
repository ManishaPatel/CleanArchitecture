import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';
import '../../domain/entities/employee.dart';
import 'add_edit_employee_page.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Employee employee;
  final String departmentId;

  const EmployeeDetailPage({
    super.key,
    required this.employee,
    required this.departmentId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.to(() => AddEditEmployeePage(
                    employee: employee,
                    departmentId: departmentId,
                  ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await Get.dialog<bool>(
                AlertDialog(
                  title: const Text('Delete Employee'),
                  content: Text('Are you sure you want to delete ${employee.name}?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Get.back(result: true),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                final success = await controller.removeEmployee(departmentId, employee.id);
                if (success) {
                  Get.back();
                  Get.snackbar('Success', 'Employee deleted successfully');
                } else {
                  Get.snackbar('Error', controller.errorMessage.value);
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  employee.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailCard(
              context,
              'Name',
              employee.name,
              Icons.person,
            ),
            const SizedBox(height: 12),
            _buildDetailCard(
              context,
              'Email',
              employee.email,
              Icons.email,
            ),
            const SizedBox(height: 12),
            _buildDetailCard(
              context,
              'Position',
              employee.position,
              Icons.work,
            ),
            const SizedBox(height: 12),
            _buildDetailCard(
              context,
              'Salary',
              '\$${employee.salary.toStringAsFixed(0)}',
              Icons.attach_money,
            ),
            const SizedBox(height: 12),
            _buildDetailCard(
              context,
              'Employee ID',
              employee.id,
              Icons.badge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue.shade700),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

