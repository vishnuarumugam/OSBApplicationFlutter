import '../app.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => LandingPageViewModel(),
  ),
  ChangeNotifierProvider(
    create: (_) => EmployeeViewModel(),
  ),
  ChangeNotifierProvider(
    create: (_) => TablePageViewModel(),
  ),
  ChangeNotifierProvider(
    create: (_) => MenuViewModel(),
  ),
  ChangeNotifierProvider(
    create: (_) => DineInPageViewModel(),
  ),
];
