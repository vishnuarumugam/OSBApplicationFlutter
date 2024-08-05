import '../../app/app.dart';

class MenuViewModel extends ChangeNotifier {
  Future<List<Menu>> getMenus() async {
    try {
      List<Menu> response = await MenuDetailRepo().getMenuItem();

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> createMenuItem(Menu menuItem) async {
    try {
      BaseResponse response = await MenuDetailRepo().createMenuItem(menuItem);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> updateMenu(Menu menu) async {
    try {
      BaseResponse response = await MenuDetailRepo().updateMenuItem(menu);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> deleteMenu(Menu menuItem) async {
    try {
      BaseResponse response = await MenuDetailRepo().deleteMenuItem(menuItem);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
