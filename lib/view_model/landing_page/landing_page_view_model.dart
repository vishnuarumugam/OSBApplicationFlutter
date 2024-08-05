import '../../app/app.dart';

class LandingPageViewModel extends ChangeNotifier {
  List<NavDestination> navBarDestinations = [];

  List<Widget> widgetOptions = <Widget>[];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }

  void setBottomNavBar() {
    navBarDestinations.clear();
    widgetOptions.clear();

    widgetOptions.add(DashboardPage(
      key: UniqueKey(),
    ));
    widgetOptions.add(EmployeePage(
      key: UniqueKey(),
    ));

    navBarDestinations.add(NavDestination(
        icon: AppImageConstants.foodBowlClosedIcon, label: "Home"));

    navBarDestinations.add(NavDestination(
        icon: AppImageConstants.foodBowlClosedIcon, label: "Orders"));
  }
}
