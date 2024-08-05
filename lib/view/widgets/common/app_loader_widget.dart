import '../../../app/app.dart';

enum LoaderSize { small, medium, large }

class AppLoaderWidget extends StatelessWidget {
  final LoaderSize size;
  final String message;
  final Color messageColor;
  final Color indicatorBackgroundColor;
  final Color indicatorForegroundColor;

  const AppLoaderWidget(
      {super.key,
      this.size = LoaderSize.medium,
      this.message = 'Please wait',
      this.messageColor = const Color(0xFF666666),
      this.indicatorBackgroundColor = const Color(0xFFF9EBF9),
      this.indicatorForegroundColor = const Color(0xFF4A154B)});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                height: getSizeOfLoaderBackground(),
                width: getSizeOfLoaderBackground(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: getVerticalPadding()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: getSizeOfLoaderIndicator(),
                          width: getSizeOfLoaderIndicator(),
                          child: CircularProgressIndicator(
                            strokeWidth: 4.0,
                            backgroundColor: indicatorBackgroundColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                indicatorForegroundColor),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          message,
                          style: TextStyle(
                              fontSize: getFontSizeOfLoader(),
                              color: messageColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getSizeOfLoaderBackground() {
    return (size == LoaderSize.large)
        ? 172.0
        : (size == LoaderSize.medium)
            ? 130.0
            : 100.0;
  }

  double getSizeOfLoaderIndicator() {
    return (size == LoaderSize.large)
        ? 56.0
        : (size == LoaderSize.medium)
            ? 48.0
            : 36.0;
  }

  double getFontSizeOfLoader() {
    return (size == LoaderSize.large) ? 16.0 : 12.0;
  }

  double getVerticalPadding() {
    return (size == LoaderSize.large)
        ? 38.0
        : (size == LoaderSize.medium)
            ? 25.0
            : 16.0;
  }
}
