import '../../../app/app.dart';

class OrderItemDetailModel {
  String? documentId;
  String? menuId;
  String? itemName;
  int? itemCount;
  int? itemPrice;
  int? totalItemPrice;

  OrderItemDetailModel.withDefaults();

  OrderItemDetailModel(
      {this.documentId,
      required this.menuId,
      required this.itemName,
      required this.itemCount,
      required this.itemPrice,
      required this.totalItemPrice});

  toJson() {
    return {
      'menu_id': menuId,
      'item_name': itemName,
      'item_count': itemCount,
      'item_price': itemPrice,
      'total_item_price': totalItemPrice,
    };
  }

  factory OrderItemDetailModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'menu_id': String menuId,
        'item_name': String itemName,
        'item_count': int itemCount,
        'item_price': int itemPrice,
        'total_item_price': int totalItemPrice,
      } =>
        OrderItemDetailModel(
          documentId: id,
          menuId: menuId,
          itemName: itemName,
          itemCount: itemCount,
          itemPrice: itemPrice,
          totalItemPrice: totalItemPrice,
        ),
      _ => throw const FormatException(
          'Failed to convert JSON to OrderItemDetailModel.'),
    };
  }

  factory OrderItemDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return switch (data) {
      {
        'menu_id': String menuId,
        'item_name': String itemName,
        'item_count': int itemCount,
        'item_price': int itemPrice,
        'total_item_price': int totalItemPrice,
      } =>
        OrderItemDetailModel(
          documentId: document.id,
          menuId: menuId,
          itemName: itemName,
          itemCount: itemCount,
          itemPrice: itemPrice,
          totalItemPrice: totalItemPrice,
        ),
      _ => throw const FormatException(
          'Failed to convert JSON to OrderItemDetailModel.'),
    };
  }
}
