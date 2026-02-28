import 'package:get/get.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/department.dart';
import '../../domain/usecases/get_all_employees.dart';
import '../../domain/usecases/get_all_departments.dart';
import '../../domain/usecases/get_employees_by_department.dart';
import '../../domain/usecases/add_employee.dart';
import '../../domain/usecases/update_employee.dart';
import '../../domain/usecases/delete_employee.dart';
import '../../core/errors/failures.dart';

class EmployeeController extends GetxController {
  final GetAllEmployees getAllEmployees;
  final GetAllDepartments getAllDepartments;
  final GetEmployeesByDepartment getEmployeesByDepartment;
  final AddEmployee addEmployee;
  final UpdateEmployee updateEmployee;
  final DeleteEmployee deleteEmployee;

  EmployeeController({
    required this.getAllEmployees,
    required this.getAllDepartments,
    required this.getEmployeesByDepartment,
    required this.addEmployee,
    required this.updateEmployee,
    required this.deleteEmployee,
  });

  final RxList<Employee> employees = <Employee>[].obs;
  final RxList<Department> departments = <Department>[].obs;
  final RxList<Employee> departmentEmployees = <Employee>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingDepartmentEmployees = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDepartments();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getAllEmployees();
    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (employeeList) => employees.value = employeeList,
    );
    
    isLoading.value = false;
  }

  Future<void> loadDepartments() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await getAllDepartments();
    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (departmentList) => departments.value = departmentList,
    );
    
    isLoading.value = false;
  }

  Future<void> loadEmployeesByDepartment(String departmentId) async {
    // First, try to get employees from already loaded departments
    try {
      final department = departments.firstWhere(
        (dept) => dept.id == departmentId,
      );
      if (department.employees.isNotEmpty) {
        departmentEmployees.value = department.employees;
        return; // Use cached data
      }
    } catch (e) {
      // Department not found in cache, continue to load from API
    }

    isLoadingDepartmentEmployees.value = true;
    errorMessage.value = '';
    
    try {
      final result = await getEmployeesByDepartment(departmentId);
      result.fold(
        (failure) {
          errorMessage.value = _mapFailureToMessage(failure);
          // If API fails, try to use employees from departments list
          try {
            final department = departments.firstWhere(
              (dept) => dept.id == departmentId,
            );
            departmentEmployees.value = department.employees;
          } catch (e) {
            departmentEmployees.value = [];
          }
        },
        (employeeList) => departmentEmployees.value = employeeList,
      );
    } catch (e) {
      errorMessage.value = 'Error loading employees: $e';
      // Fallback to employees from departments
      try {
        final department = departments.firstWhere(
          (dept) => dept.id == departmentId,
        );
        departmentEmployees.value = department.employees;
      } catch (e) {
        departmentEmployees.value = [];
      }
    } finally {
      isLoadingDepartmentEmployees.value = false;
    }
  }

  Future<bool> createEmployee(String departmentId, Employee employee) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await addEmployee(departmentId, employee);
    bool success = false;
    
    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (createdEmployee) {
        employees.add(createdEmployee);
        success = true;
      },
    );
    
    isLoading.value = false;
    return success;
  }

  Future<bool> modifyEmployee(String departmentId, String employeeId, Employee employee) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await updateEmployee(departmentId, employeeId, employee);
    bool success = false;
    
    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (updatedEmployee) {
        final index = employees.indexWhere((e) => e.id == employeeId);
        if (index != -1) {
          employees[index] = updatedEmployee;
        }
        success = true;
      },
    );
    
    isLoading.value = false;
    return success;
  }

  Future<bool> removeEmployee(String departmentId, String employeeId) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await deleteEmployee(departmentId, employeeId);
    bool success = false;
    
    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (_) {
        employees.removeWhere((e) => e.id == employeeId);
        departmentEmployees.removeWhere((e) => e.id == employeeId);
        success = true;
      },
    );
    
    isLoading.value = false;
    return success;
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred';
  }
}

