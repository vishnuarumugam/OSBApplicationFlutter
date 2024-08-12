import '../../../app/app.dart';

class MenuCategoryWidget extends StatefulWidget {
  int selectedValue;
  final void Function(String, int) onItemChange;
  bool showHeader;

  MenuCategoryWidget({
    super.key,
    required this.selectedValue,
    required this.onItemChange,
    this.showHeader = true,
  });

  @override
  State<MenuCategoryWidget> createState() => _MenuCategoryWidgetState();
}

class _MenuCategoryWidgetState extends State<MenuCategoryWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          (widget.showHeader)
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStringConstants.categories,
                    textAlign: TextAlign.start,
                    style: AppStyles.bodyHeaderBlack14,
                  ),
                )
              : const SizedBox.shrink(),
          fieldSpacer((widget.showHeader) ? 15 : 0),
          Container(
            height: 104,
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppStringConstants.foodCategoryArray.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16.0),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                var selectedIndex = widget.selectedValue;
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
                        widget.onItemChange.call("", selectedIndex);
                      } else {
                        selectedIndex = index;
                        widget.onItemChange.call(
                            AppStringConstants.foodCategoryArray[index],
                            selectedIndex);
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
}
