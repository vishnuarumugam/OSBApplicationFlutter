import 'dart:developer';

import '../../../app/app.dart';

class DineInRepo {
  final _db =
      FirebaseFirestore.instance.collection(TableNames.dineInDetailsTable);

  Future<BaseResponse> createOrder(OrderDetail orderDetail) async {
    try {
      await _db.add(orderDetail.toJson());

      return BaseResponse(
          statusCode: 200, message: AppApiStringConstants.orderAdded);
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<List<OrderDetail>> getOrders() async {
    try {
      final querySnapshot = await _db.get();
      List<OrderDetail> orderList = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final orderDetail = OrderDetail.fromJson(data, doc.id);
        orderList.add(orderDetail);
      }

      return orderList;
    } catch (e) {
      return [];
    }
  }

  Future<BaseResponse> deleteOrder(OrderDetail? orderDetail) async {
    try {
      if (orderDetail != null) {
        DocumentSnapshot snapshot = await _db.doc(orderDetail.documentId).get();
        if (!snapshot.exists) {
          throw Exception(AppApiStringConstants.orderNotFound);
        }
        await _db.doc(orderDetail.documentId).delete();
        return BaseResponse(
            statusCode: 200, message: AppApiStringConstants.orderDelete);
      } else {
        throw BaseResponse(
            statusCode: 500, message: AppApiStringConstants.serverError);
      }
    } catch (e) {
      return BaseResponse(
          statusCode: 500, message: AppApiStringConstants.serverError);
    }
  }

  Future<BaseResponse> updateOrder(OrderDetail? orderDetail) async {
    try {
      if (orderDetail != null) {
        DocumentSnapshot snapshot = await _db.doc(orderDetail.documentId).get();
        if (!snapshot.exists) {
          throw Exception(AppApiStringConstants.orderNotFound);
        }
        await _db.doc(orderDetail.documentId).update(orderDetail.toJson());
        return BaseResponse(
            statusCode: 200, message: AppApiStringConstants.orderUpdate);
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
