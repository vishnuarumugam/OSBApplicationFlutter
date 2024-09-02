import '../../../app/app.dart';

class OrderDetail {
  String? documentId;
  String? waiterName;
  String? orderStatus;
  int? updatedAt;
  List<OrderItemDetailModel>? itemList;
  int? totalOrderAmount;
  int? createdAt;
  int? occupancyCount;
  String? tableName;
  String? waiterId;

  OrderDetail.withDefaults();

  OrderDetail({
    this.documentId,
    this.waiterName,
    this.orderStatus,
    this.updatedAt,
    this.itemList,
    this.totalOrderAmount,
    this.createdAt,
    this.occupancyCount,
    this.tableName,
    this.waiterId,
  });

  OrderDetail copyWith({
    String? documentId,
    String? waiterName,
    String? orderStatus,
    int? updatedAt,
    List<OrderItemDetailModel>? itemList,
    int? totalOrderAmount,
    int? createdAt,
    int? occupancyCount,
    String? tableName,
    String? waiterId,
  }) {
    return OrderDetail(
      documentId: documentId ?? this.documentId,
      waiterName: waiterName ?? this.waiterName,
      orderStatus: orderStatus ?? this.orderStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      itemList: itemList ?? this.itemList,
      totalOrderAmount: totalOrderAmount ?? this.totalOrderAmount,
      createdAt: createdAt ?? this.createdAt,
      occupancyCount: occupancyCount ?? this.occupancyCount,
      tableName: tableName ?? this.tableName,
      waiterId: waiterId ?? this.waiterId,
    );
  }

  toJson() {
    return {
      'table_name': tableName,
      'waiter_name': waiterName,
      'waiter_id': waiterId,
      'occupancy_count': occupancyCount,
      'order_status': orderStatus,
      'item_list': itemList?.map((x) => x.toJson()).toList(),
      'total_order_amount': totalOrderAmount,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      documentId: json['documentId'] as String?,
      waiterName: json['waiter_name'] as String?,
      orderStatus: json['order_status'] as String?,
      updatedAt: json['updated_at'] as int?,
      itemList: (json['item_list'] as List<dynamic>?)
          ?.map((e) => OrderItemDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalOrderAmount: json['total_order_amount'] as int?,
      createdAt: json['created_at'] as int?,
      occupancyCount: json['occupancy_count'] as int?,
      tableName: json['table_name'] as String?,
      waiterId: json['waiter_id'] as String?,
    );
  }

  @override
  String toString() =>
      "OrderDetail(documentId: $documentId,waiterName: $waiterName,orderStatus: $orderStatus,updatedAt: $updatedAt,itemList: $itemList,totalOrderAmount: $totalOrderAmount,createdAt: $createdAt,occupancyCount: $occupancyCount,tableName: $tableName,waiterId: $waiterId)";

  @override
  int get hashCode => Object.hash(
      documentId,
      waiterName,
      orderStatus,
      updatedAt,
      itemList,
      totalOrderAmount,
      createdAt,
      occupancyCount,
      tableName,
      waiterId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDetail &&
          runtimeType == other.runtimeType &&
          documentId == other.documentId &&
          waiterName == other.waiterName &&
          orderStatus == other.orderStatus &&
          updatedAt == other.updatedAt &&
          itemList == other.itemList &&
          totalOrderAmount == other.totalOrderAmount &&
          createdAt == other.createdAt &&
          occupancyCount == other.occupancyCount &&
          tableName == other.tableName &&
          waiterId == other.waiterId;
}
