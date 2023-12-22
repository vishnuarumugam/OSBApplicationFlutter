import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osb/common/constant.dart';
import 'package:osb/model/employee_model.dart';

class FirebaseFirestoreService{

  final CollectionReference _collection;

  FirebaseFirestoreService(String collectionName) : _collection = FirebaseFirestore.instance.collection(collectionName);

  Future<void> addDocument(Employee employee) async {
    print({'addDocument'});
    await _collection.add({
      'employeeCategory' : employee.employeeCategory,
      'employeeName' : employee.employeeName,
      'employeeSalary' : employee.employeeSalary,
      'dateOfJoining' : employee.dateOfJoining,
      'gender' : employee.gender
    });
  }

  Future<void> updateDocument(String documentId, Employee employee) async {
    await _collection.doc(documentId).update({
      'employeeCategory' : employee.employeeCategory,
      'employeeName' : employee.employeeName,
      'employeeSalary' : employee.employeeSalary,
      'dateOfJoining' : employee.dateOfJoining,
      'gender' : employee.gender
    });
  }

  Future<void> deleteDocument(String documentId) async {
    await _collection.doc(documentId).delete();
  }

  Future<List<Employee>> getDocuments() async {
    final querySnapshot = await _collection.get();
    return querySnapshot.docs.map((doc) => doc.data() as Employee).toList();
  }

}