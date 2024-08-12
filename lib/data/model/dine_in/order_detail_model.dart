import '../../../app/app.dart';

class OrderDetail {
  String? documentId;
  String? tableName;
  String? waiterName;
  String? waiterId;
  int? occupancyCount;
  String? orderStatus;
  List<OrderItemDetailModel>? itemList;
  int? totalOrderAmount;
  int? createdAt;
  int? updatedAt;

  OrderDetail.withDefaults();

  OrderDetail(
      {this.documentId,
      required this.tableName,
      required this.waiterName,
      required this.waiterId,
      required this.occupancyCount,
      required this.orderStatus,
      required this.createdAt,
      required this.updatedAt});

  toJson() {
    return {
      'table_name': tableName,
      'waiter_name': waiterName,
      'waiter_id': waiterId,
      'occupancy_count': occupancyCount,
      'order_status': orderStatus,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'table_name': String tableName,
        'waiter_name': String waiterName,
        'waiter_id': String waiterId,
        'occupancy_count': int occupancyCount,
        'order_status': String orderStatus,
        'created_at': int createdAt,
        'updated_at': int updatedAt,
      } =>
        OrderDetail(
            documentId: id,
            tableName: tableName,
            waiterName: waiterName,
            waiterId: waiterId,
            occupancyCount: occupancyCount,
            orderStatus: orderStatus,
            createdAt: createdAt,
            updatedAt: updatedAt),
      _ => throw const FormatException(
          'Failed to convert JSON to Employee model.'),
    };
  }

  factory OrderDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return switch (data) {
      {
        'table_name': String tableName,
        'waiter_name': String waiterName,
        'waiter_id': String waiterId,
        'occupancy_count': int occupancyCount,
        'order_status': String orderStatus,
        'created_at': int createdAt,
        'updated_at': int updatedAt,
      } =>
        OrderDetail(
            documentId: document.id,
            tableName: tableName,
            waiterName: waiterName,
            waiterId: waiterId,
            occupancyCount: occupancyCount,
            orderStatus: orderStatus,
            createdAt: createdAt,
            updatedAt: updatedAt),
      _ => throw const FormatException(
          'Failed to convert JSON to Employee model.'),
    };
  }
}
