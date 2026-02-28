import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/employee_controller.dart';
import '../../core/services/notification_service.dart';
import '../../core/di/injection_container.dart';
import 'employees_page.dart';
import 'photo_upload_page.dart';
import 'login_page.dart';

class DepartmentsPage extends StatelessWidget {
  const DepartmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get or create controller
    EmployeeController controller;
    try {
      controller = Get.find<EmployeeController>();
    } catch (e) {
      // If controller not found, setup dependency injection and try again
      setupDependencyInjection();
      controller = Get.find<EmployeeController>();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Demonstrate push notification
              NotificationService.showLocalNotification(
                title: 'Employee Management',
                body: 'You have ${controller.departments.length} departments',
              );
              Get.snackbar(
                'Notification',
                'Local notification sent!',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            tooltip: 'Test Notification',
          ),
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () {
              Get.to(() => const PhotoUploadPage());
            },
            tooltip: 'Upload Photo',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = Get.find<SharedPreferences>();
              await prefs.setBool('isLoggedIn', false);
              Get.offAll(() => const LoginPage());
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.departments.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.departments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.business, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No departments found',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.departments.length,
          itemBuilder: (context, index) {
            final department = controller.departments[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.business, color: Colors.blue.shade700),
                ),
                title: Text(
                  department.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Location: ${department.location}'),
                    Text('Employees: ${department.employees.length}'),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.to(() => EmployeesPage(departmentId: department.id));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.loadDepartments(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

