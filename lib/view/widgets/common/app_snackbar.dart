import '../../../../app/app.dart';

class AppSnackBar {
  void showSnackbar(BuildContext context, String message, bool actionRequired) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppStyles.buttonTvStyle),
        duration: const Duration(seconds: 3),
        action: actionRequired
            ? SnackBarAction(
                label: 'Action',
                onPressed: () {
                  // Perform an action when the user taps on the action button
                },
              )
            : null,
      ),
    );
  }
}
