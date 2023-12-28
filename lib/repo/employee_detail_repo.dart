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
  // createEmployee(Employee employee){
  //   _db.add(employee.toJson()).whenComplete(
  //         () => BaseResponse(statusCode: 200, message: 'Employeee added successfully')
  //   )
  //   .catchError((error, stackTrace){
  //       // ignore: invalid_return_type_for_catch_error
  //       return BaseResponse(statusCode: 500, message: 'Error found while adding employee record.');
  //   });
  // }

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

}