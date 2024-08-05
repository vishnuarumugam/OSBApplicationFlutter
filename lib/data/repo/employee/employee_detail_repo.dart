import '../../../../app/app.dart';

class EmployeeDetailRepo {
  final _db =
      FirebaseFirestore.instance.collection(TableNames.employeeDetailsTable);

  Future<BaseResponse> createEmployee(Employee employee) async {
    try {
      await _db.add(employee.toJson());

      return BaseResponse(
          statusCode: 200, message: AppApiStringConstants.employeeAdded);
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final querySnapshot = await _db.get();
      List<Employee> employeeList = [];
      final employeeData =
          querySnapshot.docs.map((e) => Employee.fromSnapshot(e));

      for (var employee in employeeData) {
        employeeList.add(employee);
      }
      return employeeList;
    } catch (e) {
      return [];
    }
  }

  Future<BaseResponse> deleteEmployee(String? documentId) async {
    try {
      DocumentSnapshot snapshot = await _db.doc(documentId).get();
      if (!snapshot.exists) {
        throw Exception(AppApiStringConstants.employeeNotFound);
      }
      await _db.doc(documentId).delete();
      return BaseResponse(
          statusCode: 200, message: AppApiStringConstants.employeeDelete);
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<BaseResponse> updateEmployee(Employee? employee) async {
    try {
      if (employee != null) {
        DocumentSnapshot snapshot = await _db.doc(employee.documentId).get();
        if (!snapshot.exists) {
          throw Exception(AppApiStringConstants.employeeNotFound);
        }
        await _db.doc(employee.documentId).update(employee.toJson());
        return BaseResponse(
            statusCode: 200, message: AppApiStringConstants.employeeUpdate);
      } else {
        throw BaseResponse(
            statusCode: 500, message: AppApiStringConstants.serverError);
      }
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }
}
