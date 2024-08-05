import '../../../../app/app.dart';

class TableRepo {
  final _db =
      FirebaseFirestore.instance.collection(TableNames.tableDetailsTable);

  Future<BaseResponse> createTable(DTable table) async {
    try {
      await _db.add(table.toJson());

      return BaseResponse(
          statusCode: 200, message: AppApiStringConstants.tableAdded);
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<List<DTable>> getTables() async {
    try {
      final querySnapshot = await _db.get();
      List<DTable> tableList = [];
      final tableData = querySnapshot.docs.map((e) => DTable.fromSnapshot(e));

      for (var table in tableData) {
        tableList.add(table);
      }
      return tableList;
    } catch (e) {
      return [];
    }
  }

  Future<BaseResponse> deleteTable(String? documentId) async {
    try {
      DocumentSnapshot snapshot = await _db.doc(documentId).get();
      if (!snapshot.exists) {
        throw Exception(AppApiStringConstants.tableNotFound);
      }
      await _db.doc(documentId).delete();
      return BaseResponse(
          statusCode: 200, message: AppApiStringConstants.tableDelete);
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<BaseResponse> updateTable(DTable? table) async {
    try {
      if (table != null) {
        DocumentSnapshot snapshot = await _db.doc(table.documentId).get();
        if (!snapshot.exists) {
          throw Exception(AppApiStringConstants.tableNotFound);
        }
        await _db.doc(table.documentId).update(table.toJson());
        return BaseResponse(
            statusCode: 200, message: AppApiStringConstants.tableUpdate);
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
