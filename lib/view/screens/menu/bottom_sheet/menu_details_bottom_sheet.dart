import '../../../../app/app.dart';

class MenuDetailBottomSheet extends StatefulWidget {
  final VoidCallback onMenuListChanged;
  final String sheetOpenedFor;
  final Menu? menuItemData;

  const MenuDetailBottomSheet(
      {super.key,
      required this.onMenuListChanged,
      required this.sheetOpenedFor,
      this.menuItemData});

  @override
  _MenuDetailBottomSheetState createState() => _MenuDetailBottomSheetState(
      onMenuListChanged, menuItemData, sheetOpenedFor);
}

class _MenuDetailBottomSheetState extends State<MenuDetailBottomSheet> {
  late TextEditingController menuItemName = TextEditingController();
  late TextEditingController menuItemPrice = TextEditingController();
  bool isMenuTypeListOpen = false;
  int itemAvailableDaily = 1;

  late Menu menuItemDetails = Menu.withDefaults();
  final VoidCallback onSuccessfulChange;
  final Menu? menuItemData;
  final String sheetOpenedFor;

  _MenuDetailBottomSheetState(
      this.onSuccessfulChange, this.menuItemData, this.sheetOpenedFor);

  List<String> menuTypeList = AppStringConstants.foodCategoryArray;

  @override
  initState() {
    super.initState();
    if (sheetOpenedFor == SheetNames.edit) {
      if (menuItemData != null) {
        menuItemDetails = menuItemData ?? Menu.withDefaults();
        menuItemName.text = menuItemData!.itemName ?? AppStringConstants.dashed;
        menuItemPrice.text = menuItemData!.itemPrice.toString();
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed to free up resources
    menuItemName.dispose();
    menuItemPrice.dispose();
    super.dispose();
  }

  createMenuItem() async {
    showLoader(context);
    try {
      var response = await Provider.of<MenuViewModel>(context, listen: false)
          .createMenuItem(menuItemDetails);
      if (response.statusCode == 200) {
        widget.onMenuListChanged();
      }
      Navigator.pop(context);
      AppSnackBar().showSnackbar(
          context, response.message ?? AppStringConstants.dashed, false);
      hideLoader();
    } catch (error) {
      hideLoader();
      rethrow;
    }
  }

  updateMenuItem() async {
    showLoader(context);
    try {
      var response = await Provider.of<MenuViewModel>(context, listen: false)
          .updateMenu(menuItemDetails);
      if (response.statusCode == 200) {
        widget.onMenuListChanged();
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      extendBody: false,
      bottomNavigationBar: bottomButtons(context),
      body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  fieldSpacer(15),
                  menuTypeComponent(),
                  fieldSpacer(15),
                  itemNameComponent(),
                  fieldSpacer(15),
                  itemPriceComponent(),
                  fieldSpacer(15),
                  itemAvailableComponent(),
                ],
              ),
              if (isMenuTypeListOpen) categoryDropDown(),
            ]),
          )),
    );
  }

  Column menuTypeComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.itemCategory}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isMenuTypeListOpen = true;
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
                menuItemDetails.itemType == null
                    ? AppStringConstants.selectItemCategory
                    : menuItemDetails.itemType ?? AppStringConstants.dashed,
                style: menuItemDetails.itemType == null
                    ? AppStyles.inputHintTvStyle
                    : AppStyles.inputTvStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column itemNameComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.itemName}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: menuItemName,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.enterItemName,
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

  Column itemPriceComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.itemPrice}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: menuItemPrice,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.enterItemPrice,
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

  Positioned categoryDropDown() {
    return Positioned(
      top: 85,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 0.0)
            ]),
        height: 200,
        child: categoryListComponent(),
      ),
    );
  }

  ListView categoryListComponent() => ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: menuTypeList.length,
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
              menuItemDetails.itemType = menuTypeList[index];
              isMenuTypeListOpen = false;
            });
          },
          child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              color: AppColors.colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  menuTypeList[index],
                  style: AppStyles.bodyMediumBlack14,
                ),
              )),
        );
      });

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
                      addMenuItem(pageContext);
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

  void addMenuItem(BuildContext pageContext) async {
    if (validateData()) {
      if (sheetOpenedFor == SheetNames.add) {
        menuItemDetails.createdAt = DateTime.now().millisecondsSinceEpoch;
        createMenuItem();
      } else {
        updateMenuItem();
      }
    }
  }

  bool validateData() {
    if (menuItemDetails.itemType == null) {
      return false;
    }
    if (menuItemName.text.isEmpty) {
      return false;
    }

    if (menuItemPrice.text.isEmpty) {
      return false;
    }

    menuItemDetails.itemName = menuItemName.text;
    menuItemDetails.itemPrice = int.parse(menuItemPrice.text);
    menuItemDetails.updatedAt = DateTime.now().millisecondsSinceEpoch;
    return true;
  }

  Column itemAvailableComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
              '${AppStringConstants.itemAvailable}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            radioButton(AppStringConstants.yes, 1),
            const SizedBox(width: 15),
            radioButton(AppStringConstants.no, 0),
          ],
        ),
      ],
    );
  }

  Widget radioButton(String name, int availableValue) => GestureDetector(
      onTap: () {
        setState(() {
          itemAvailableDaily = availableValue;
          menuItemDetails.isItemAvailable = availableValue;
        });
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: itemAvailableDaily == availableValue
                ? AppColors.colorDark
                : AppColors.colorWhite,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: AppColors.colorDark, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Text(name,
              style: TextStyle(
                fontSize: 14,
                color: itemAvailableDaily == availableValue
                    ? AppColors.colorWhite
                    : AppColors.colorDark,
              )),
        ),
      ));
}
