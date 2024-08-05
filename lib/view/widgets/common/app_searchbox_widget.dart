import '../../../app/app.dart';

class AppSearchBoxWidget extends StatefulWidget {
  final double width;
  final double height;
  final Color fillColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final VoidCallback? onPrefixIconTap;
  final bool? showPrefixIcon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final VoidCallback? onSuffixIconTap;
  final bool? showSuffixIcon;
  final String? hintText;
  final FontWeight? hintTextFontWeight;
  final double? hintTextFontSize;
  final Color? hintTextColor;
  final double focusBorderWidth;
  final double focusBorderRadius;
  final Color focusedBorderColor;
  final double disabledBorderWidth;
  final double disabledBorderRadius;
  final Color disabledBorderColor;
  final double enabledBorderWidth;
  final double enabledBorderRadius;
  final Color enabledBorderColor;
  final TextEditingController? controller;
  final dynamic itemList;
  final bool showSearchList;
  final Function(String)? onChanged;

  // final FocusNode? focusNode;
  final bool isDisabled;
  final void Function(dynamic)? onItemSelected;
  final String? searchItemKey;

  const AppSearchBoxWidget({
    super.key,
    this.height = 48.0,
    this.width = 312.0,
    this.fillColor = const Color(0xffFFFFFF),
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconSize,
    this.onPrefixIconTap,
    this.showPrefixIcon = true,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.onSuffixIconTap,
    this.showSuffixIcon = true,
    this.hintText = "Search anything",
    this.hintTextFontWeight = FontWeight.w500,
    this.hintTextFontSize = 16.0,
    this.hintTextColor = const Color(0xff8F8F8F),
    this.focusBorderWidth = 1.0,
    this.focusBorderRadius = 4.0,
    this.focusedBorderColor = const Color(0xff4A154B),
    this.disabledBorderWidth = 1.0,
    this.disabledBorderRadius = 4.0,
    this.disabledBorderColor = const Color(0xffF0F0F0),
    this.enabledBorderWidth = 1.0,
    this.enabledBorderRadius = 4.0,
    this.enabledBorderColor = const Color(0xffCCCCCC),
    this.controller,
    this.itemList,
    this.showSearchList = false,
    this.onChanged,
    // this.focusNode,
    this.isDisabled = false,
    this.onItemSelected,
    this.searchItemKey,
  });

  static IconData defaultIcon = Icons.circle;
  static double defaultIconSize = 24.0;
  static Color defaultIconColor = const Color(0xff4A154B);

  @override
  State<AppSearchBoxWidget> createState() => _AppSearchBoxWidgetState();
}

class _AppSearchBoxWidgetState extends State<AppSearchBoxWidget> {
  TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  dynamic filteredList = [];
  dynamic selectedValue = '';

  @override
  void initState() {
    super.initState();
    filteredList.addAll(widget.itemList ?? []);
    searchController.addListener(() {
      updateSearch(searchController.text);
    });
  }

  void updateSearch(String query) {
    setState(() {
      filteredList.clear();
      if (widget.itemList != null && widget.itemList!.isNotEmpty) {
        if (widget.itemList is List<Map<String, dynamic>>) {
          filterMapList(query);
        } else {
          filterListOfString(query);
        }
      }
    });
  }

  void filterMapList(String query) {
    for (var map in widget.itemList!) {
      for (var value in map.values) {
        if (value is String &&
            value.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(map);
          break;
        }
      }
    }
  }

  void filterListOfString(String query) {
    setState(() {
      final RegExp regex = RegExp(query, caseSensitive: false);
      filteredList =
          widget.itemList!.where((item) => regex.hasMatch(item)).toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: widget.width,
                height: widget.height,
                child: TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff525252),
                      fontSize: 16.0),
                  onChanged: (val) {
                    updateSearch(val);
                    widget.onChanged?.call(val);
                  },
                  focusNode: searchNode,
                  controller: searchController,
                  enabled: widget.isDisabled == false,
                  decoration: InputDecoration(
                      fillColor: widget.isDisabled
                          ? const Color(0xffF0F0F0)
                          : widget.fillColor,
                      contentPadding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
                      filled: true,
                      prefixIcon: widget.showPrefixIcon == true
                          ? GestureDetector(
                              onTap: widget.onPrefixIconTap,
                              child: Icon(
                                widget.prefixIcon ??
                                    AppSearchBoxWidget.defaultIcon,
                                size: widget.prefixIconSize ??
                                    AppSearchBoxWidget.defaultIconSize,
                                color: widget.isDisabled
                                    ? const Color(0xffB8B8B8)
                                    : widget.prefixIconColor ??
                                        AppSearchBoxWidget.defaultIconColor,
                              ),
                            )
                          : null,
                      suffixIcon: searchController.text.isNotEmpty &&
                              widget.showSuffixIcon!
                          ? GestureDetector(
                              onTap: () {
                                searchController.clear();
                                updateSearch('');
                                selectedValue = '';
                                setState(() {});
                                widget.onSuffixIconTap?.call();
                              },
                              child: Icon(
                                widget.suffixIcon ??
                                    AppSearchBoxWidget.defaultIcon,
                                size: widget.suffixIconSize ??
                                    AppSearchBoxWidget.defaultIconSize,
                                color: widget.isDisabled
                                    ? const Color(0xffB8B8B8)
                                    : widget.suffixIconColor ??
                                        AppSearchBoxWidget.defaultIconColor,
                              ),
                            )
                          : null,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                          fontWeight: widget.hintTextFontWeight,
                          fontSize: widget.hintTextFontSize,
                          color: widget.isDisabled
                              ? const Color(0xffB8B8B8)
                              : widget.hintTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: widget.focusBorderWidth,
                            color: widget.focusedBorderColor),
                        borderRadius:
                            BorderRadius.circular(widget.focusBorderRadius),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: widget.disabledBorderWidth,
                            color: widget.disabledBorderColor),
                        borderRadius:
                            BorderRadius.circular(widget.disabledBorderRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: widget.enabledBorderWidth,
                            color: widget.enabledBorderColor),
                        borderRadius:
                            BorderRadius.circular(widget.enabledBorderRadius),
                      )),
                ),
              ),
              if ((searchController.text.trim().isNotEmpty &&
                      filteredList.isNotEmpty) &&
                  widget.showSearchList)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: const Border(
                        bottom: BorderSide(color: Color(0xff4A154B)),
                        left: BorderSide(color: Color(0xff4A154B)),
                        right: BorderSide(color: Color(0xff4A154B)),
                        top: BorderSide(width: 0.1, color: Color(0xff4A154B))),
                  ),
                  width: 312.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedValue = filteredList[index];
                            searchController.text = widget.searchItemKey != null
                                ? selectedValue[widget.searchItemKey]
                                : selectedValue.toString();
                            filteredList.clear();
                          });
                          searchNode.unfocus();
                          widget.onItemSelected?.call(selectedValue);
                        },
                        contentPadding:
                            const EdgeInsets.only(left: 12.0, right: 12.0),
                        leading: const Icon(Icons.circle,
                            size: 24.0, color: Color(0xff666666)),
                        title: Text(
                          widget.searchItemKey != null
                              ? filteredList[index][widget.searchItemKey]
                              : filteredList[index].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Color(0xff525252)),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
