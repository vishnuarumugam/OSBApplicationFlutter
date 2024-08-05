import '../../../app/app.dart';

class Menu {
  String? documentId;
  String? itemImage;
  String? itemName;
  String? itemType;
  int? itemPrice;
  int? itemQty = 1;
  int? isBestSeller = 0;
  int? isItemAvailable = 1;
  int? isDeleted = 0;
  int? createdAt;
  int? updatedAt;

  Menu.withDefaults();

  Menu(
      {this.documentId,
      this.itemImage,
      required this.itemName,
      required this.itemType,
      required this.itemPrice,
      required this.itemQty,
      required this.isBestSeller,
      required this.isItemAvailable,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});

  toJson() {
    return {
      'item_image': itemImage,
      'item_name': itemName,
      'item_type': itemType,
      'item_price': itemPrice,
      'item_qty': itemQty,
      'is_best_seller': isBestSeller,
      'is_item_available': isItemAvailable,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Menu.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'item_image': String? itemImage,
        'item_name': String? itemName,
        'item_type': String? itemType,
        'item_price': int? itemPrice,
        'item_qty': int? itemQty,
        'is_best_seller': int? isBestSeller,
        'is_item_available': int? isItemAvailable,
        'is_deleted': int? isDeleted,
        'created_at': int? createdAt,
        'updated_at': int? updatedAt,
      } =>
        Menu(
            documentId: id,
            itemImage: itemImage,
            itemName: itemName,
            itemType: itemType,
            itemPrice: itemPrice,
            itemQty: itemQty,
            isBestSeller: isBestSeller,
            isItemAvailable: isItemAvailable,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt),
      _ => throw const FormatException('Failed to convert JSON to Menu model.'),
    };
  }

  factory Menu.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return switch (data) {
      {
        'item_image': String? itemImage,
        'item_name': String? itemName,
        'item_type': String? itemType,
        'item_price': int? itemPrice,
        'item_qty': int? itemQty,
        'is_best_seller': int? isBestSeller,
        'is_item_available': int? isItemAvailable,
        'is_deleted': int? isDeleted,
        'created_at': int? createdAt,
        'updated_at': int? updatedAt,
      } =>
        Menu(
            documentId: document.id,
            itemImage: itemImage,
            itemName: itemName,
            itemType: itemType,
            itemPrice: itemPrice,
            itemQty: itemQty,
            isBestSeller: isBestSeller,
            isItemAvailable: isItemAvailable,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt),
      _ => throw const FormatException('Failed to convert JSON to Menu model.'),
    };
  }
}
