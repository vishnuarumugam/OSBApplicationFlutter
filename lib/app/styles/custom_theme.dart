import '../app.dart';

ThemeData customTheme() {
  // Primary and accent colors
  Color primaryColor = AppColors.colorDark;
  Color secondaryColor = AppColors.colorLight;

  return ThemeData(
    primaryColor: primaryColor,

    // Color scheme based on the custom colors
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        background: AppColors.colorWhite,
        surfaceTint: AppColors.colorWhite),

    // Custom text styles for headings, body, etc.
    textTheme: GoogleFonts.poppinsTextTheme(),

    // Custom background color
    scaffoldBackgroundColor: AppColors.colorWhite,
  );
}
