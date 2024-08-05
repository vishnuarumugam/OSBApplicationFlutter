import '../../../app/app.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = -1;
  List<Menu> menuListResponse = [];
  Future<List<Menu>>? searchMenuList;

  @override
  initState() {
    super.initState();
    getMenuItem();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onLeadingTap: () {
          Navigator.pop(context);
        },
        onActionTap: () {},
        showLeading: true,
        showAction: false,
        title: AppStringConstants.menu,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorDark,
        shape: const CircleBorder(),
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: screenView(),
    );
  }

  Widget screenView() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      margin: const EdgeInsets.only(top: 15, bottom: 0),
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            searchWidget(),
            fieldSpacer(15),
            categoryFilter(),
            fieldSpacer(8),
            listHeading(),
            fetchMenuListComponent(),
          ],
        ),
      ),
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

  Widget categoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStringConstants.categories,
              textAlign: TextAlign.start,
              style: AppStyles.bodyHeaderBlack14,
            ),
          ),
          fieldSpacer(15),
          Container(
            height: 104,
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppStringConstants.foodCategoryArray.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16.0),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final categoryName =
                    AppStringConstants.foodCategoryArray[index];
                final categoryImage =
                    AppImageConstants.foodCategoryImageArray[index];
                var iconSize = ((index == 2) || (index == 3)) ? 44.0 : 50.0;
                var textTopPadding = ((index == 2) || (index == 3)) ? 6.0 : 0.0;
                return Container(
                  width: 85,
                  height: 85,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? AppColors.colorDark.withOpacity(0.7)
                          : AppColors.colorLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorShadow.withOpacity(0.1),
                          blurRadius: 1,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 1),
                        )
                      ]),
                  child: InkWell(
                    onTap: () {
                      if (selectedIndex == index) {
                        selectedIndex = -1;
                        searchMenuList = filterMenuCategory("");
                      } else {
                        selectedIndex = index;
                        searchMenuList = filterMenuCategory(
                            AppStringConstants.foodCategoryArray[index]);
                      }
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            categoryImage,
                            height: iconSize,
                            width: iconSize,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: textTopPadding),
                            child: Text(
                              categoryName,
                              style: AppStyles.bodyRegularBlack12,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Padding listHeading() {
    return const Padding(
        padding: EdgeInsets.only(left: 15, top: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(AppStringConstants.menu,
              textAlign: TextAlign.left, style: AppStyles.bodyRegularBlack12),
        ));
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
              height: MediaQuery.sizeOf(context).height * 0.4,
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
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.6,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          var menuItem = menuList[index];
          return Container(
            decoration: BoxDecoration(
                color: AppColors.colorLight,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorGreyOut.withOpacity(0.1),
                    blurRadius: 1,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: InkWell(
              onTap: () {
                _showUpdateBottomSheet(context, menuItem);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menuItem.itemName ?? AppStringConstants.dashed,
                            style: AppStyles.bodyHeaderBlack14,
                            textAlign: TextAlign.left,
                          ),
                          fieldSpacer(8),
                          Text(
                            menuItem.itemType ?? AppStringConstants.dashed,
                            style: AppStyles.bodyRegularBlack12,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (menuItem.itemPrice != null)
                                ? "${AppStringConstants.rupeeSymbol} ${menuItem.itemPrice.toString()}"
                                : AppStringConstants.dashed,
                            style: AppStyles.bodyHeaderBlack14,
                            textAlign: TextAlign.left,
                          ),
                          // fieldSpacer(8),
                          // Text(
                          //   categoryName,
                          //   style: AppStyles.bodyRegularBlack12,
                          //   textAlign: TextAlign.left,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MenuDetailBottomSheet(
            onMenuListChanged: getMenuItem,
            sheetOpenedFor: SheetNames.add,
            menuItemData: null);
      },
    );
  }

  void _showUpdateBottomSheet(BuildContext context, Menu menu) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MenuUpdateBottomSheet(
            menuItemData: menu,
            onMenuListChanged: getMenuItem,
            onUpdateCalled: handleUpdateCallback);
      },
    );
  }

  void handleUpdateCallback(Menu menu) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MenuDetailBottomSheet(
            onMenuListChanged: getMenuItem,
            sheetOpenedFor: SheetNames.edit,
            menuItemData: menu);
      },
    );
  }
}
