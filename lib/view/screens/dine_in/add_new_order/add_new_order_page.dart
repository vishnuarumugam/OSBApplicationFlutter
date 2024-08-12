import '../../../../app/app.dart';

class AddNewOrderPage extends StatefulWidget {
  const AddNewOrderPage({super.key});

  @override
  State<AddNewOrderPage> createState() => _AddNewOrderPageState();
}

class _AddNewOrderPageState extends State<AddNewOrderPage> {
  late TextEditingController tableName = TextEditingController();
  late TextEditingController waiterName = TextEditingController();

  List<Employee> employeeListResponse = [];
  List<DTable> tableListResponse = [];
  bool isEmployeeListOpen = false;
  bool isTableListOpen = false;
  late OrderDetail orderDetails = OrderDetail.withDefaults();
  List<Menu> menuListResponse = [];
  Future<List<Menu>>? searchMenuList;
  int selectedIndex = -1;

  @override
  initState() {
    super.initState();
    getEmployees();
    getTables();
    getMenuItem();
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

  Future<void> getTables() async {
    var tableList =
        await Provider.of<TablePageViewModel>(context, listen: false)
            .getTables();

    if (tableList.isNotEmpty) {
      tableListResponse = tableList;
    } else {
      tableListResponse = [];
    }
    setState(() {});
  }

  Future<void> getMenuItem() async {
    var menuList =
        await Provider.of<MenuViewModel>(context, listen: false).getMenus();

    if (menuList.isNotEmpty) {
      menuListResponse = menuList;
      searchMenuList = Future.value(menuList);
    } else {
      menuListResponse = [];
      searchMenuList = Future.value([]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
          title: AppStringConstants.newOrder,
          showLeading: true,
          showAction: false),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screenView(),
    );
  }

  Widget screenView() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.8,
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                tableDetailComponent(),
                fieldSpacer(15),
                searchWidget(),
                fieldSpacer(8),
                MenuCategoryWidget(
                  showHeader: false,
                  selectedValue: selectedIndex,
                  onItemChange: onCategoryChange,
                ),
                fieldSpacer(8),
                fetchMenuListComponent(),
                fieldSpacer(30),
              ],
            ),
            if (isEmployeeListOpen) employeeDropDown(),
            if (isTableListOpen) tableDropDown(),
          ],
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return Container(
      alignment: Alignment.center,
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(
          color: AppColors.colorGridLine,
          width: 2.0,
        )),
        color: AppColors.colorWhite,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  if (validateOrderData()) {
                    pushToScreen(context,
                        NewOrderConfirmationPage(orderDetails: orderDetails));
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width,
                    constraints: const BoxConstraints(minHeight: 48),
                    decoration: BoxDecoration(
                        color: validateOrderData()
                            ? AppColors.colorDark
                            : AppColors.colorGreyOut,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: const Text(
                      AppStringConstants.reviewOrder,
                      style: AppStyles.buttonTvStyle,
                    ))),
          ]),
    );
  }

  Widget searchWidget() {
    return AppSearchBoxWidget(
      width: MediaQuery.sizeOf(context).width,
      searchItemKey: AppStringConstants.searchMenuKey,
      hintText: AppStringConstants.searchMenu,
      onChanged: (menuName) {
        searchMenuList = searchMenuItem(menuName);
        selectedIndex = -1;
        setState(() {});
      },
      focusBorderRadius: 10,
      enabledBorderRadius: 10,
      enabledBorderColor: AppColors.colorGridLine,
      focusedBorderColor: AppColors.colorGridLine,
      prefixIconColor: AppColors.placeholderTextColor,
      suffixIconColor: AppColors.colorDark,
      prefixIcon: Icons.search,
      suffixIcon: Icons.close,
      onSuffixIconTap: () {
        searchMenuList = searchMenuItem('');
        setState(() {});
      },
    );
  }

  Future<List<Menu>> searchMenuItem(String query) async {
    if (menuListResponse.isEmpty) {
      return [];
    } else {
      return menuListResponse
          .where((menu) =>
              (menu.itemName ?? '').toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Widget tableDetailComponent() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: AppColors.colorLight),
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 5, child: tableNumberComponent()),
              Expanded(flex: 1, child: fieldSpacer(8)),
              Expanded(flex: 3, child: occupancyComponent()),
            ],
          ),
          fieldSpacer(8),
          waiterNameComponent(),
        ],
      ),
    );
  }

  Column tableNumberComponent() {
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
          child: InkWell(
            onTap: () {
              setState(() {
                isTableListOpen = !isTableListOpen;
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
                textAlign: TextAlign.left,
                orderDetails.tableName == null
                    ? AppStringConstants.selectTableName
                    : orderDetails.tableName ?? AppStringConstants.dashed,
                style: orderDetails.tableName == null
                    ? AppStyles.inputHintTvStyle
                    : AppStyles.inputTvStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column occupancyComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.occupancy}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        AppItemCounterWidget(
          onItemChange: memberChange,
          counterValue: 0,
        )
      ],
    );
  }

  FutureBuilder fetchMenuListComponent() => FutureBuilder<List<Menu>>(
      future: searchMenuList,
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
            return menuItemListComponent(data);
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: const Center(
                child: Text(
                  AppStringConstants.noMenuItem,
                  style: AppStyles.bodyMessageColorDark14,
                ),
              ),
            );
          }
        }
      });

  Widget menuItemListComponent(List<Menu> menuList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        var menuItem = menuList[index];
        return MenuItemCardWidget(
          menuItem: menuItem,
          cardType: ItemCardType.orderList,
          onItemAdded: addItem,
          onItemRemoved: removeItem,
        );
      },
    );
  }

  Column waiterNameComponent() {
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
          child: InkWell(
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
                orderDetails.waiterName == null
                    ? AppStringConstants.selectWaiterName
                    : orderDetails.waiterName ?? AppStringConstants.dashed,
                style: orderDetails.waiterName == null
                    ? AppStyles.inputHintTvStyle
                    : AppStyles.inputTvStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Positioned employeeDropDown() {
    return Positioned(
      top: 175,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
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

  Positioned tableDropDown() {
    return Positioned(
      top: 102,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
        child: tableListComponent(),
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
              isEmployeeListOpen = false;
              orderDetails.waiterId = employeeListResponse[index].documentId;
              orderDetails.waiterName =
                  employeeListResponse[index].employeeName;
            });
          },
          child: Container(
              margin: const EdgeInsets.all(10),
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

  ListView tableListComponent() => ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: tableListResponse.length,
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
              isTableListOpen = false;
              orderDetails.tableName = tableListResponse[index].tableName;
            });
          },
          child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              color: AppColors.colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  tableListResponse[index].tableName ?? "",
                  style: AppStyles.bodyMediumBlack14,
                ),
              )),
        );
      });

  void memberChange(memberCount) {
    orderDetails.occupancyCount = memberCount;
    setState(() {});
  }

  void onCategoryChange(searchValue, selectedValue) {
    searchMenuList = filterMenuCategory(searchValue);
    selectedIndex = selectedValue;
    setState(() {});
  }

  Future<List<Menu>> filterMenuCategory(String query) async {
    if (menuListResponse.isEmpty) {
      return [];
    } else {
      if (query.isEmpty) {
        return menuListResponse;
      } else {
        return menuListResponse
            .where((menu) => (menu.itemType ?? '')
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    }
  }

  void addItem(orderItem) {
    if (orderDetails.itemList != null) {
      int index = (orderDetails.itemList ?? [])
          .indexWhere((item) => item.menuId == orderItem.menuId);

      if (index != -1) {
        orderDetails.itemList?[index] = orderItem;
      } else {
        orderDetails.itemList?.add(orderItem);
      }
    } else {
      orderDetails.itemList = [];
      orderDetails.itemList?.add(orderItem);
    }
    setState(() {});
  }

  void removeItem(orderItem) {
    int index = (orderDetails.itemList ?? [])
        .indexWhere((item) => item.menuId == orderItem.menuId);

    if (index != -1) {
      orderDetails.itemList?.removeAt(index);
    }
    setState(() {});
  }

  bool validateOrderData() {
    if (orderDetails.tableName == null) {
      return false;
    }
    if (orderDetails.waiterName == null) {
      return false;
    }
    if ((orderDetails.occupancyCount == null) ||
        ((orderDetails.occupancyCount ?? 0) < 1)) {
      return false;
    }
    if (orderDetails.itemList == null ||
        (orderDetails.itemList?.isEmpty ?? true)) {
      return false;
    }
    return true;
  }
}
