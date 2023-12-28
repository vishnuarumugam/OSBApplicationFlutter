
import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String? documentId;
  String? employeeCategory;
  String? employeeName;
  int? employeeSalary;
  int?  dateOfJoining;
  int? gender;

  Employee.withDefaults(
    
  );
  
  Employee({
    this.documentId,
    required this.employeeCategory,
    required this.employeeName,
    required this.employeeSalary,
    required this.dateOfJoining,
    required this.gender
  });

  static List<Employee> getEmployees(){
      List<Employee> employees = [];

      employees.add(
        Employee(
          employeeName: 'Mani',
          employeeCategory: 'Waiter',
          employeeSalary: 250,
          dateOfJoining: 1448889376000,
          gender: 0
        )
      );

      employees.add(
        Employee(
          employeeName: 'Mani(CBR)',
          employeeCategory: 'Waiter',
          employeeSalary: 400,
          dateOfJoining: 1448889376000,
          gender: 0
        )
      );

      employees.add(
        Employee(
          employeeName: 'Sundar',
          employeeCategory: 'Cleaner',
          employeeSalary: 250,
          dateOfJoining: 1448889376000,
          gender: 0
        )
      );

    employees.add(
        Employee(
          employeeName: 'Shanthi',
          employeeCategory: 'Waiter',
          employeeSalary: 400,
          dateOfJoining: 1448889376000,
          gender: 1
        )
      );
    

      return employees;
    }

  toJson(){
    return {
      "category": employeeCategory,
      "name": employeeName,
      "salary": employeeSalary,
      "date_of_joining": dateOfJoining,
      "gender": gender
    };
  }

  factory Employee.fromJson(Map<String, dynamic> json){
    return switch (json) {
        { 'id': String id,
          'category': String category,
          'name': String name,
          'salary': int salary,
          'date_of_joining': int date_of_joining,
          'gender': int gender,
        } =>
          Employee(
            documentId: id,
            employeeCategory: category,
            employeeName: name,
            employeeSalary: salary,
            dateOfJoining: date_of_joining,
            gender: gender
          ),
        _ => throw const FormatException('Failed to convert JSON to Employee model.'),
      };
  }

  factory Employee.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data();
    return switch (data) {
        {
          'category': String category,
          'name': String name,
          'salary': int salary,
          'date_of_joining': int date_of_joining,
          'gender': int gender,
        } =>
          Employee(
            documentId: document.id,
            employeeCategory: category,
            employeeName: name,
            employeeSalary: salary,
            dateOfJoining: date_of_joining,
            gender: gender
          ),
        _ => throw const FormatException('Failed to convert JSON to Employee model.'),
      };
  }

}