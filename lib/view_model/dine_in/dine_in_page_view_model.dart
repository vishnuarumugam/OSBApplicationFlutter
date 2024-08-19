import '../../app/app.dart';

class DineInPageViewModel extends ChangeNotifier {
  Future<List<OrderDetail>> getOrders() async {
    try {
      List<OrderDetail> response = await DineInRepo().getOrders();

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> createOrder(OrderDetail orderDetail) async {
    try {
      BaseResponse response = await DineInRepo().createOrder(orderDetail);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> updateOrder(OrderDetail orderDetail) async {
    try {
      BaseResponse response = await DineInRepo().updateOrder(orderDetail);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<BaseResponse> deleteOrder(OrderDetail orderDetail) async {
    try {
      BaseResponse response = await DineInRepo().deleteOrder(orderDetail);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
