import '../../app.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<DateTime?> displayDatePicker(
    BuildContext context, DateTime selectedDate) async {
  return await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    builder: (context, child) => Theme(
        data: ThemeData(
          primaryColor: AppColors.colorDark,
          colorScheme: const ColorScheme.light(primary: AppColors.colorDark),
        ),
        child: child!),
  );
}

SizedBox fieldSpacer(double space) => SizedBox(height: space);

showLoader(BuildContext context) => Loader.show(context,
    isSafeAreaOverlay: true,
    isBottomBarOverlay: true,
    overlayColor: Colors.black26,
    progressIndicator:
        customLoader(navigatorKey.currentState?.context ?? context));

hideLoader() => Loader.hide();

customLoader(BuildContext context) {
  return AppLoaderWidget(
      indicatorForegroundColor: Theme.of(context).primaryColor);
}

pushToScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
