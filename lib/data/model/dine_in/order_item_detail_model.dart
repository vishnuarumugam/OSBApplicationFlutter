class OrderItemDetailModel {
  int? itemCount;
  int? totalItemPrice;
  int? itemPrice;
  String? itemName;
  String? menuId;

  OrderItemDetailModel({
    this.itemCount,
    this.totalItemPrice,
    this.itemPrice,
    this.itemName,
    this.menuId,
  });

  OrderItemDetailModel.withDefaults();

  OrderItemDetailModel copyWith({
    int? itemCount,
    int? totalItemPrice,
    int? itemPrice,
    String? itemName,
    String? menuId,
  }) {
    return OrderItemDetailModel(
      itemCount: itemCount ?? this.itemCount,
      totalItemPrice: totalItemPrice ?? this.totalItemPrice,
      itemPrice: itemPrice ?? this.itemPrice,
      itemName: itemName ?? this.itemName,
      menuId: menuId ?? this.menuId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_count': itemCount,
      'total_item_price': totalItemPrice,
      'item_price': itemPrice,
      'item_name': itemName,
      'menu_id': menuId,
    };
  }

  factory OrderItemDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderItemDetailModel(
      itemCount: json['item_count'] as int?,
      totalItemPrice: json['total_item_price'] as int?,
      itemPrice: json['item_price'] as int?,
      itemName: json['item_name'] as String?,
      menuId: json['menu_id'] as String?,
    );
  }

  @override
  String toString() =>
      "ItemList(itemCount: $itemCount,totalItemPrice: $totalItemPrice,itemPrice: $itemPrice,itemName: $itemName,menuId: $menuId)";

  @override
  int get hashCode =>
      Object.hash(itemCount, totalItemPrice, itemPrice, itemName, menuId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemDetailModel &&
          runtimeType == other.runtimeType &&
          itemCount == other.itemCount &&
          totalItemPrice == other.totalItemPrice &&
          itemPrice == other.itemPrice &&
          itemName == other.itemName &&
          menuId == other.menuId;
}
