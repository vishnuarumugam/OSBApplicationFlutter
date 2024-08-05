import '../../app/app.dart';

class EmployeeViewModel extends ChangeNotifier {
  Future<List<Employee>> getEmployees() async {
    try {
      List<Employee> response = await EmployeeDetailRepo().getEmployees();

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> createEmployee(Employee employeeDetails) async {
    try {
      BaseResponse response =
          await EmployeeDetailRepo().createEmployee(employeeDetails);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> updateEmployee(Employee employeeDetails) async {
    try {
      BaseResponse response =
          await EmployeeDetailRepo().updateEmployee(employeeDetails);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> deleteEmployee(Employee employeeDetails) async {
    try {
      BaseResponse response =
          await EmployeeDetailRepo().deleteEmployee(employeeDetails.documentId);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
