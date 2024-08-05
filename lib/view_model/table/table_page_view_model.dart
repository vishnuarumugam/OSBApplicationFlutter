import '../../../app/app.dart';

class TablePageViewModel extends ChangeNotifier {
  Future<List<DTable>> getTables() async {
    try {
      List<DTable> response = await TableRepo().getTables();

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> createTable(DTable tableDetails) async {
    try {
      BaseResponse response = await TableRepo().createTable(tableDetails);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> updateTable(DTable tableDetails) async {
    try {
      BaseResponse response = await TableRepo().updateTable(tableDetails);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> deleteEmployee(DTable tableDetails) async {
    try {
      BaseResponse response =
          await TableRepo().deleteTable(tableDetails.documentId);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
