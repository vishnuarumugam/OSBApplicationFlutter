import '../../../app/app.dart';

enum Mode { lightMode, darkMode }

class AppBottomNavBarWidget extends StatelessWidget {
  final Mode mode;
  final double? height;
  final Function(int)? onDestinationSelected;
  final int selectedIndex;
  final String menuItemOneLabel;
  final IconData menuItemIconOne;
  final String menuItemTwoLabel;
  final IconData menuItemIconTwo;
  final String menuItemThreeLabel;
  final IconData menuItemIconThree;
  final String menuItemFourLabel;
  final IconData menuItemIconFour;
  final String menuItemFiveLabel;
  final IconData menuItemIconFive;
  final double fontSize;
  final double iconSize;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;
  final Color? selectedLabelColor;
  final Color? unSelectedLabelColor;
  final bool showMenuItemOne;
  final bool showMenuItemTwo;
  final bool showMenuItemThree;
  final bool showMenuItemFour;
  final bool showMenuItemFive;
  final Color backgroundColor;
  final List<NavDestination> destinations;

  const AppBottomNavBarWidget(
      {Key? key,
      this.mode = Mode.lightMode,
      this.height,
      this.onDestinationSelected,
      this.selectedIndex = 0,
      this.menuItemOneLabel = "Item One",
      this.menuItemIconOne = Icons.home,
      this.menuItemTwoLabel = "Item Two",
      this.menuItemIconTwo = Icons.search,
      this.menuItemThreeLabel = "Item Three",
      this.menuItemIconThree = Icons.favorite,
      this.menuItemFourLabel = "Item Four",
      this.menuItemIconFour = Icons.shopping_cart,
      this.menuItemFiveLabel = "Item Five",
      this.menuItemIconFive = Icons.person,
      this.iconSize = 24.0,
      this.fontSize = 12.0,
      this.selectedIconColor,
      this.unSelectedIconColor,
      this.selectedLabelColor,
      this.unSelectedLabelColor,
      this.showMenuItemOne = true,
      this.showMenuItemTwo = true,
      this.showMenuItemThree = false,
      this.showMenuItemFour = false,
      this.showMenuItemFive = false,
      this.backgroundColor = const Color(0xffFFFFFF),
      required this.destinations})
      : super(key: key);

  static Color defaultSelectedIconColor = const Color(0xff4A154B);
  static Color defaultUnSelectedIconColor = const Color(0xff666666);
  static Color defaultSelectedLabelColor = const Color(0xff4A154B);
  static Color defaultUnSelectedLabelColor = const Color(0xff666666);
  static Color darkModeDefaultSelectedIconColor = const Color(0xFFDCE6ED);
  static Color darModeDefaultUnSelectedIconColor = const Color(0xffE0E0E0);

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        height: height,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor:
            mode == Mode.darkMode ? const Color(0xFF203A4E) : backgroundColor,
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? labelTextStyle(
                  mode == Mode.darkMode
                      ? const Color(0xffFFFFFF)
                      : selectedLabelColor ?? defaultSelectedIconColor,
                  FontWeight.w500)
              : labelTextStyle(
                  mode == Mode.darkMode
                      ? const Color(0xffFFFFFF)
                      : unSelectedLabelColor ?? defaultUnSelectedLabelColor,
                  FontWeight.w400),
        ),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: onDestinationSelected,
        indicatorColor: mode == Mode.darkMode
            ? const Color(0xffF9EBF9).withOpacity(0.1)
            : const Color(0xffF9EBF9),
        destinations: destinations.asMap().entries.map((entry) {
          final index = entry.key;
          final destination = entry.value;
          return InkWell(
            onTap: () {
              onDestinationSelected!(index);
            },
            child: SvgPicture.asset(
                width: 24,
                height: 24,
                destination.icon,
                colorFilter: ColorFilter.mode(
                    selectedIndex == index
                        ? AppColors.colorDark
                        : AppColors.colorGreyOut,
                    BlendMode.srcIn)),
          );
        }).toList(),
      ),
    );
  }

  TextStyle labelTextStyle(Color labelColor, FontWeight fontWeight) {
    return TextStyle(
      color: labelColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xFFFF8034);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
