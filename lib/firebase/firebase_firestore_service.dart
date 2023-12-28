import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osb/common/utils/constant.dart';
import 'package:osb/model/employee/employee_model.dart';

class FirebaseFirestoreService{

  final CollectionReference _collection;

  FirebaseFirestoreService(String collectionName) : _collection = FirebaseFirestore.instance.collection(collectionName);

  Future<void> addDocument(Map<String, dynamic> data) async {
    try {
      await _collection.add(data);
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<void> updateDocument(String documentId, Map<String, dynamic> data) async {
    await _collection.doc(documentId).update(data);
  }

  Future<void> deleteDocument(String documentId) async {
    await _collection.doc(documentId).delete();
  }

  Future<List<Map<String, dynamic>>> getDocuments() async {
    final querySnapshot = await _collection.get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

}