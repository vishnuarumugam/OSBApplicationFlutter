import '../common/utils/constant.dart';
import '../model/base/base_response.dart';
import '../model/employee/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeDetailRepo{

  final _db = FirebaseFirestore.instance.collection(TableNames.employeeDetailsTable);

  

  Future<BaseResponse> createEmployee(Employee employee) async {
    try {
      await _db.add(employee.toJson());

      return BaseResponse(statusCode: 200, message: 'Employee added successfully.');
    } catch (e) {
      return BaseResponse(statusCode: 500, message: 'Error found while adding employee record.');
    }
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final querySnapshot = await _db.get();
      List<Employee> employeeList = [];
      // final dynamic jsonResponse = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      final employeeData = querySnapshot.docs.map((e) => Employee.fromSnapshot(e));

      for (var employee in employeeData){
        employeeList.add(
          employee
        );
      }
      return employeeList;
    }catch (e) {
      // Handle errors appropriately (e.g., logging or throwing an exception)
      print('Error fetching employees: $e');
      return [];
    }
    
  }

  Future<BaseResponse> deleteEmployee(String? documentId) async {
    try {
      DocumentSnapshot snapshot = await _db.doc(documentId).get();
      if (!snapshot.exists){
        throw Exception('Document does not exist');
      }
      await _db.doc(documentId).delete();
      return BaseResponse(statusCode: 200, message: 'Employee deleted successfully.');
    } catch (e) {
      return BaseResponse(statusCode: 500, message: 'Error while deleting employee record.');
    }
  }

  Future<BaseResponse> updateEmployee(Employee? employee) async {
    try {
      if (employee != null){
        DocumentSnapshot snapshot = await _db.doc(employee.documentId).get();
        if (!snapshot.exists){
          throw Exception('Document does not exist');
        }
        await _db.doc(employee.documentId).update(employee.toJson());
        return BaseResponse(statusCode: 200, message: 'Employee update successfully.');
      }else{
        throw Exception('Employee cannot be null');
      }
    } catch (e) {
      return BaseResponse(statusCode: 500, message: 'Error while updating employee record.');
    }
  }

}