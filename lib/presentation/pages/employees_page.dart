import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';
import '../../domain/entities/department.dart';
import '../../core/di/injection_container.dart';
import 'employee_detail_page.dart';
import 'add_edit_employee_page.dart';

class EmployeesPage extends StatefulWidget {
  final String departmentId;

  const EmployeesPage({super.key, required this.departmentId});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  void initState() {
    super.initState();
    EmployeeController controller;
    try {
      controller = Get.find<EmployeeController>();
    } catch (e) {
      setupDependencyInjection();
      controller = Get.find<EmployeeController>();
    }
    controller.loadEmployeesByDepartment(widget.departmentId);
  }

  @override
  Widget build(BuildContext context) {
    EmployeeController controller;
    try {
      controller = Get.find<EmployeeController>();
    } catch (e) {
      setupDependencyInjection();
      controller = Get.find<EmployeeController>();
    }
    Department? department;
    try {
      department = controller.departments.firstWhere(
        (dept) => dept.id == widget.departmentId,
      );
    } catch (e) {
      department = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(department?.name ?? 'Employees'),
      ),
      body: Obx(() {
        if (controller.isLoadingDepartmentEmployees.value && controller.departmentEmployees.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.departmentEmployees.isEmpty && !controller.isLoadingDepartmentEmployees.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No employees in this department',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.departmentEmployees.length,
          itemBuilder: (context, index) {
            final employee = controller.departmentEmployees[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Text(
                    employee.name[0].toUpperCase(),
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ),
                title: Text(
                  employee.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Position: ${employee.position}'),
                    Text('Email: ${employee.email}'),
                    Text('Salary: \$${employee.salary.toStringAsFixed(0)}'),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.to(() => EmployeeDetailPage(
                        employee: employee,
                        departmentId: widget.departmentId,
                      ));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddEditEmployeePage(departmentId: widget.departmentId));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

