import '../../../app/app.dart';

class Employee {
  String? documentId;
  String? employeeRole;
  String? employeeName;
  int? employeeSalary;
  int? dateOfJoining;
  int? gender;

  Employee.withDefaults();

  Employee(
      {this.documentId,
      required this.employeeRole,
      required this.employeeName,
      required this.employeeSalary,
      required this.dateOfJoining,
      required this.gender});

  toJson() {
    return {
      'role': employeeRole,
      'name': employeeName,
      'salary': employeeSalary,
      'date_of_joining': dateOfJoining,
      'gender': gender
    };
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'role': String role,
        'name': String name,
        'salary': int salary,
        'date_of_joining': int date_of_joining,
        'gender': int gender,
      } =>
        Employee(
            documentId: id,
            employeeRole: role,
            employeeName: name,
            employeeSalary: salary,
            dateOfJoining: date_of_joining,
            gender: gender),
      _ => throw const FormatException(
          'Failed to convert JSON to Employee model.'),
    };
  }

  factory Employee.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return switch (data) {
      {
        'role': String role,
        'name': String name,
        'salary': int salary,
        'date_of_joining': int date_of_joining,
        'gender': int gender,
      } =>
        Employee(
            documentId: document.id,
            employeeRole: role,
            employeeName: name,
            employeeSalary: salary,
            dateOfJoining: date_of_joining,
            gender: gender),
      _ => throw const FormatException(
          'Failed to convert JSON to Employee model.'),
    };
  }
}
