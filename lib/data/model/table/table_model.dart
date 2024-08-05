import '../../../app/app.dart';

class DTable {
  String? documentId;
  String? tableName;
  String? tableWaiter;
  int? memberCount;

  DTable.withDefaults();

  DTable(
      {this.documentId,
      required this.tableName,
      required this.tableWaiter,
      required this.memberCount});

  toJson() {
    return {
      'table_name': tableName,
      'table_waiter': tableWaiter,
      'member_count': memberCount,
    };
  }

  factory DTable.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'table_name': String tableName,
        'table_waiter': String tableWaiter,
        'member_count': int memberCount,
      } =>
        DTable(
          documentId: id,
          tableName: tableName,
          tableWaiter: tableWaiter,
          memberCount: memberCount,
        ),
      _ =>
        throw const FormatException('Failed to convert JSON to DTable model.'),
    };
  }

  factory DTable.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return switch (data) {
      {
        'table_name': String tableName,
        'table_waiter': String tableWaiter,
        'member_count': int memberCount,
      } =>
        DTable(
          documentId: document.id,
          tableName: tableName,
          tableWaiter: tableWaiter,
          memberCount: memberCount,
        ),
      _ =>
        throw const FormatException('Failed to convert JSON to DTable model.'),
    };
  }
}
