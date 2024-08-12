import '../../../../app/app.dart';

class TableDetailsBottomSheet extends StatefulWidget {
  final VoidCallback onTableListChanged;
  final String sheetOpenedFor;
  final DTable? tableData;

  const TableDetailsBottomSheet(
      {super.key,
      required this.onTableListChanged,
      required this.sheetOpenedFor,
      this.tableData});

  @override
  State<TableDetailsBottomSheet> createState() =>
      _TableDetailsBottomSheetState();
}

class _TableDetailsBottomSheetState extends State<TableDetailsBottomSheet> {
  late TextEditingController tableName = TextEditingController();
  late TextEditingController occupantCount = TextEditingController();
  late DTable tableDetails = DTable.withDefaults();
  List<Employee> employeeListResponse = [];
  bool isEmployeeListOpen = false;

  createTable() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<TablePageViewModel>(context, listen: false)
              .createTable(tableDetails);
      if (response.statusCode == 200) {
        widget.onTableListChanged();
      }
      Navigator.pop(context);
      showToast(context, response.message);
      hideLoader();
    } catch (error) {
      hideLoader();
      rethrow;
    }
  }

  updateTable() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<TablePageViewModel>(context, listen: false)
              .updateTable(tableDetails);
      if (response.statusCode == 200) {
        widget.onTableListChanged();
      }
      Navigator.pop(context);
      hideLoader();
      showToast(context, response.message);
    } catch (error) {
      hideLoader();
      rethrow;
    }
  }

  @override
  initState() {
    super.initState();
    getEmployees();
    if (widget.sheetOpenedFor == SheetNames.edit) {
      if (widget.tableData != null) {
        tableDetails = widget.tableData ?? DTable.withDefaults();
        tableName.text =
            widget.tableData?.tableName ?? AppStringConstants.dashed;
        occupantCount.text = (widget.tableData?.memberCount ?? 0).toString();
      }
    }
  }

  Future<void> getEmployees() async {
    var employeeList =
        await Provider.of<EmployeeViewModel>(context, listen: false)
            .getEmployees();

    if (employeeList.isNotEmpty) {
      employeeListResponse = employeeList;
    } else {
      employeeListResponse = [];
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed to free up resources
    tableName.dispose();
    occupantCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      extendBody: false,
      bottomNavigationBar: bottomButtons(context),
      body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    fieldSpacer(15),
                    nameComponent(),
                    fieldSpacer(15),
                    employeeComponent(),
                    fieldSpacer(15),
                    tableCountComponent(),
                    fieldSpacer(150),
                  ],
                ),
                if (isEmployeeListOpen) employeeDropDown(),
              ],
            ),
          )),
    );
  }

  Column nameComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.tableName}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: tableName,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.enterTableName,
              hintStyle: AppStyles.inputHintTvStyle,
              fillColor: AppColors.colorWhite,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Positioned employeeDropDown() {
    return Positioned(
      top: 170,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        constraints: const BoxConstraints(minHeight: 80, maxHeight: 200),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 0.0)
            ]),
        child: employeeListComponent(),
      ),
    );
  }

  ListView employeeListComponent() => ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: employeeListResponse.length,
      separatorBuilder: (context, index) => const SizedBox(
            height: 1,
            child: Divider(
              color: AppColors.colorGridLine,
              thickness: 1.5,
            ),
          ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              tableDetails.tableWaiter =
                  employeeListResponse[index].employeeName;
              isEmployeeListOpen = false;
            });
          },
          child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              color: AppColors.colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  employeeListResponse[index].employeeName ?? "",
                  style: AppStyles.bodyMediumBlack14,
                ),
              )),
        );
      });

  Column employeeComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.waiterName}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isEmployeeListOpen = !isEmployeeListOpen;
              });
            },
            child: Container(
              constraints: const BoxConstraints(maxHeight: 52),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  width: 1.5,
                  color: AppColors.colorGridLine,
                ),
              ),
              child: Text(
                tableDetails.tableWaiter == null
                    ? AppStringConstants.selectWaiterName
                    : tableDetails.tableWaiter ?? AppStringConstants.dashed,
                style: tableDetails.tableWaiter == null
                    ? AppStyles.inputHintTvStyle
                    : AppStyles.inputTvStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column tableCountComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.occupantsCount}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: occupantCount,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.enterOccupantsCount,
              hintStyle: AppStyles.inputHintTvStyle,
              fillColor: AppColors.colorWhite,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container bottomButtons(BuildContext pageContext) => Container(
        height: 80,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: AppColors.colorWhite, boxShadow: [
          BoxShadow(
            color: AppColors.colorGreyOut.withOpacity(0.9),
            offset: const Offset(0, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ]),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      constraints: const BoxConstraints(minHeight: 45),
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        shape: BoxShape.rectangle,
                        border:
                            Border.all(color: AppColors.colorDark, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Text(
                        AppStringConstants.cancel,
                        style: AppStyles.buttonTvStyleColorDark,
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      addTable(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      constraints: const BoxConstraints(minHeight: 45),
                      decoration: const BoxDecoration(
                        color: AppColors.colorBlack,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Text(
                        AppStringConstants.submit,
                        style: AppStyles.buttonTvStyle,
                      ),
                    ))),
          ],
        ),
      );

  void addTable(BuildContext pageContext) async {
    if (validateData()) {
      if (widget.sheetOpenedFor == SheetNames.add) {
        createTable();
      } else {
        updateTable();
      }
    }
  }

  bool validateData() {
    if (tableName.text.isEmpty) {
      return false;
    }
    if (tableDetails.tableWaiter == null) {
      return false;
    }
    if (occupantCount.text.isEmpty) {
      return false;
    }
    tableDetails.tableName = tableName.text.toString();
    tableDetails.memberCount = int.parse(occupantCount.text);
    return true;
  }
}
