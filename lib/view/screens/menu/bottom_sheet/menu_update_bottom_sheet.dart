import '../../../../app/app.dart';

class MenuUpdateBottomSheet extends StatefulWidget {
  final Menu menuItemData;
  final VoidCallback onMenuListChanged;
  final void Function(Menu) onUpdateCalled;

  const MenuUpdateBottomSheet(
      {super.key,
      required this.menuItemData,
      required this.onMenuListChanged,
      required this.onUpdateCalled});

  @override
  _MenuUpdateBottomSheetState createState() =>
      _MenuUpdateBottomSheetState(menuItemData, onUpdateCalled);
}

class _MenuUpdateBottomSheetState extends State<MenuUpdateBottomSheet> {
  final Menu menuItemData;
  final void Function(Menu) onUpdateCalled;

  _MenuUpdateBottomSheetState(this.menuItemData, this.onUpdateCalled);

  deleteMenuItem() async {
    showLoader(context);
    try {
      var response = await Provider.of<MenuViewModel>(context, listen: false)
          .deleteMenu(menuItemData);
      if (response.statusCode == 200) {
        widget.onMenuListChanged();
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
          onUpdateCalled(menuItemData);
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
          menuItemData.isDeleted = 1;
          deleteMenuItem();
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
