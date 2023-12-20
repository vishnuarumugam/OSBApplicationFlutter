
class Employee {
  String employeeCategory;
  String employeeName;
  int employeeSalary;
  int  dateOfJoining;
  int gender;

  Employee({
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
}