import '../../../../app/app.dart';

class TableUpdateBottomSheet extends StatefulWidget {
  final DTable tableData;
  final VoidCallback onTableListChanged;
  final void Function(DTable) onUpdateCalled;

  const TableUpdateBottomSheet(
      {super.key,
      required this.tableData,
      required this.onTableListChanged,
      required this.onUpdateCalled});

  @override
  _TableUpdateBottomSheetState createState() =>
      _TableUpdateBottomSheetState(tableData, onUpdateCalled);
}

class _TableUpdateBottomSheetState extends State<TableUpdateBottomSheet> {
  final DTable tableData;
  final void Function(DTable) onUpdateCalled;

  _TableUpdateBottomSheetState(this.tableData, this.onUpdateCalled);

  deleteEmployee() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<TablePageViewModel>(context, listen: false)
              .deleteEmployee(tableData);
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
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        constraints: const BoxConstraints(maxHeight: 200),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: updateButton(context)),
              Expanded(flex: 1, child: deleteButton(context)),
            ],
          ),
          cancelButton(context)
        ]));
  }

  GestureDetector updateButton(BuildContext pageContext) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          onUpdateCalled(tableData);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          constraints: const BoxConstraints(minHeight: 45),
          decoration: const BoxDecoration(
            color: AppColors.colorBlack,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: const Text(
            AppStringConstants.update,
            style: AppStyles.buttonTvStyle,
          ),
        ));
  }

  GestureDetector deleteButton(BuildContext pageContext) {
    return GestureDetector(
        onTap: () {
          deleteEmployee();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          constraints: const BoxConstraints(minHeight: 45),
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            shape: BoxShape.rectangle,
            border: Border.all(color: AppColors.colorDark, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: const Text(
            AppStringConstants.delete,
            style: AppStyles.buttonTvStyleColorDark,
          ),
        ));
  }

  GestureDetector cancelButton(BuildContext pageContext) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          constraints: const BoxConstraints(minHeight: 45),
          decoration: const BoxDecoration(
            color: AppColors.colorGreyOut,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: const Text(
            AppStringConstants.cancel,
            style: AppStyles.buttonTvStyle,
          ),
        ));
  }
}
