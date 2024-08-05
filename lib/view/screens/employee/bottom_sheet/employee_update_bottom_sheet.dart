import '../../../../app/app.dart';

class EmployeeUpdateBottomSheet extends StatefulWidget {
  final Employee employeeData;
  final VoidCallback onEmployeeListChanged;
  final void Function(Employee) onUpdateCalled;

  const EmployeeUpdateBottomSheet(
      {super.key,
      required this.employeeData,
      required this.onEmployeeListChanged,
      required this.onUpdateCalled});

  @override
  _EmployeeUpdateBottomSheetState createState() =>
      _EmployeeUpdateBottomSheetState(employeeData, onUpdateCalled);
}

class _EmployeeUpdateBottomSheetState extends State<EmployeeUpdateBottomSheet> {
  final Employee employeeData;
  final void Function(Employee) onUpdateCalled;

  _EmployeeUpdateBottomSheetState(this.employeeData, this.onUpdateCalled);

  deleteEmployee() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<EmployeeViewModel>(context, listen: false)
              .deleteEmployee(employeeData);
      if (response.statusCode == 200) {
        widget.onEmployeeListChanged();
      }
      Navigator.pop(context);
      hideLoader();
      AppSnackBar().showSnackbar(
          context, response.message ?? AppStringConstants.dashed, false);
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
        child: Column(children: [
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
          onUpdateCalled(employeeData);
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
            color: AppColors.colorDarkBg,
            shape: BoxShape.rectangle,
            border: Border.all(color: AppColors.colorDarkBg, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: const Text(
            AppStringConstants.delete,
            style: AppStyles.buttonTvStyle,
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
