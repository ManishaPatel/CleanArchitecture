import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/employee_remote_data_source.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../../domain/repositories/employee_repository.dart';
import '../../domain/usecases/get_all_employees.dart';
import '../../domain/usecases/get_all_departments.dart';
import '../../domain/usecases/get_employees_by_department.dart';
import '../../domain/usecases/add_employee.dart';
import '../../domain/usecases/update_employee.dart';
import '../../domain/usecases/delete_employee.dart';
import '../../presentation/controllers/employee_controller.dart';

void setupDependencyInjection() {
  // Data Sources
  Get.lazyPut<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(client: http.Client()),
  );

  // Repositories
  Get.lazyPut<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      remoteDataSource: Get.find<EmployeeRemoteDataSource>(),
    ),
  );

  // Use Cases
  Get.lazyPut(() => GetAllEmployees(Get.find<EmployeeRepository>()));
  Get.lazyPut(() => GetAllDepartments(Get.find<EmployeeRepository>()));
  Get.lazyPut(() => GetEmployeesByDepartment(Get.find<EmployeeRepository>()));
  Get.lazyPut(() => AddEmployee(Get.find<EmployeeRepository>()));
  Get.lazyPut(() => UpdateEmployee(Get.find<EmployeeRepository>()));
  Get.lazyPut(() => DeleteEmployee(Get.find<EmployeeRepository>()));

  // Controllers - Use put instead of lazyPut to ensure it's always available
  Get.put(
    EmployeeController(
      getAllEmployees: Get.find<GetAllEmployees>(),
      getAllDepartments: Get.find<GetAllDepartments>(),
      getEmployeesByDepartment: Get.find<GetEmployeesByDepartment>(),
      addEmployee: Get.find<AddEmployee>(),
      updateEmployee: Get.find<UpdateEmployee>(),
      deleteEmployee: Get.find<DeleteEmployee>(),
    ),
    permanent: true,
  );
}

