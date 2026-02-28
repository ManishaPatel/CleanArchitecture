class ApiConstants {
  // Spring Boot backend URL
  static const String baseUrl = 'http://localhost:8080/api';
  
  // Employee endpoints
  static const String employeesEndpoint = '/employees';
  static String employeesByDepartmentEndpoint(String deptId) => '/departments/$deptId/employees';
  static String addEmployeeEndpoint(String deptId) => '/departments/$deptId/employees';
  static String updateEmployeeEndpoint(String deptId, String empId) => '/departments/$deptId/employees/$empId';
  static String deleteEmployeeEndpoint(String deptId, String empId) => '/departments/$deptId/employees/$empId';
  
  // Department endpoints
  static const String departmentsEndpoint = '/departments';
  
  // Report endpoints
  static const String employeeReportEndpoint = '/reports/employees/pdf';
}

