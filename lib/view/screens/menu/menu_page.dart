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
      appBar: const CommonAppBar(
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
            MenuCategoryWidget(
                selectedValue: selectedIndex, onItemChange: onCategoryChange),
            fieldSpacer(8),
            listHeading(),
            fieldSpacer(8),
            fetchMenuListComponent(),
            fieldSpacer(65),
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

  void onCategoryChange(searchValue, selectedValue) {
    searchMenuList = filterMenuCategory(searchValue);
    selectedIndex = selectedValue;
    setState(() {});
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        var menuItem = menuList[index];
        return MenuItemCardWidget(
          menuItem: menuItem,
          onItemClick: _showUpdateBottomSheet,
          cardType: ItemCardType.menuList,
        );
      },
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

  void _showUpdateBottomSheet(menu) {
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
