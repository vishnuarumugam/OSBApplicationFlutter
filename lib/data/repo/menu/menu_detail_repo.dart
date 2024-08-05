import '../../../../app/app.dart';

class MenuDetailRepo {
  final _db =
      FirebaseFirestore.instance.collection(TableNames.menuDetailsTable);

  Future<BaseResponse> createMenuItem(Menu menu) async {
    try {
      await _db.add(menu.toJson());

      return BaseResponse(
          statusCode: 200, message: AppApiStringConstants.menuAdded);
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<List<Menu>> getMenuItem() async {
    try {
      final querySnapshot = await _db.get();
      List<Menu> menuItemList = [];
      final menuItemData = querySnapshot.docs.map((e) => Menu.fromSnapshot(e));

      for (var menuItem in menuItemData) {
        menuItemList.add(menuItem);
      }
      return menuItemList;
    } catch (e) {
      return [];
    }
  }

  Future<BaseResponse> deleteMenuItem(Menu? menu) async {
    try {
      if (menu != null) {
        DocumentSnapshot snapshot = await _db.doc(menu.documentId).get();
        if (!snapshot.exists) {
          throw Exception(AppApiStringConstants.menuNotFound);
        }
        await _db.doc(menu.documentId).update(menu.toJson());
        return BaseResponse(
            statusCode: 200, message: AppApiStringConstants.menuDelete);
      } else {
        throw BaseResponse(
            statusCode: 500, message: AppApiStringConstants.serverError);
      }
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<BaseResponse> updateMenuItem(Menu? menu) async {
    try {
      if (menu != null) {
        DocumentSnapshot snapshot = await _db.doc(menu.documentId).get();
        if (!snapshot.exists) {
          throw Exception(AppApiStringConstants.menuNotFound);
        }
        await _db.doc(menu.documentId).update(menu.toJson());
        return BaseResponse(
            statusCode: 200, message: AppApiStringConstants.menuUpdate);
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
