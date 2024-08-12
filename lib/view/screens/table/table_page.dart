import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  Future<List<DTable>>? tableListResponse;

  @override
  void initState() {
    tableListResponse = getTables();
    super.initState();
  }

  Future<List<DTable>> getTables() async {
    var tableValues =
        await Provider.of<TablePageViewModel>(context, listen: false)
            .getTables();
    return tableValues;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        showLeading: true,
        showAction: false,
        title: AppStringConstants.table,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorDark,
        shape: const CircleBorder(),
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: fetchTableListComponent(),
    );
  }

  FutureBuilder fetchTableListComponent() => FutureBuilder<List<DTable>>(
      future: tableListResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final data = snapshot.data;
          if (data != null && data.isNotEmpty) {
            return tableListComponent(data);
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: const Center(
                child: Text(
                  AppStringConstants.noTables,
                  style: AppStyles.bodyMessageColorDark14,
                ),
              ),
            );
          }
        }
      });

  Widget tableListComponent(List<DTable>? tableData) {
    return Container(
        margin: const EdgeInsets.only(top: 15, bottom: 60),
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.2,
          children:
              tableData?.map((data) => tableComponent(data)).toList() ?? [],
        ));
  }

  Widget tableComponent(DTable data) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showUpdateBottomSheet(context, data);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.colorDark,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 1,
                  spreadRadius: 0.0,
                  offset: const Offset(1, 0),
                ),
                BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 1,
                  spreadRadius: 0.0,
                  offset: const Offset(-1, 0),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data.tableName ?? AppStringConstants.dashed,
                  style: AppStyles.headingLight16,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showUpdateBottomSheet(context, data);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.colorLight,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 1,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            AppStringConstants.waiter,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(":"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            (data.tableWaiter ?? AppStringConstants.dashed)
                                .toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            AppStringConstants.occupancy,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(":"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "${(data.memberCount ?? AppStringConstants.dashed).toString()} ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TableDetailsBottomSheet(
            onTableListChanged: _handleTableListModified,
            sheetOpenedFor: SheetNames.add,
            tableData: null);
      },
    );
  }

  void _showUpdateBottomSheet(BuildContext context, DTable table) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TableUpdateBottomSheet(
            tableData: table,
            onTableListChanged: _handleTableListModified,
            onUpdateCalled: _handleUpdateCallback);
      },
    );
  }

  void _handleTableListModified() {
    tableListResponse = getTables();
    setState(() {});
  }

  void _handleUpdateCallback(DTable table) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TableDetailsBottomSheet(
            onTableListChanged: _handleTableListModified,
            sheetOpenedFor: SheetNames.edit,
            tableData: table);
      },
    );
  }
}
