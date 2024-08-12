import '../../../../app/app.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onActionTap;
  final bool showLeading;
  final bool showAction;

  const CommonAppBar(
      {super.key,
      required this.title,
      this.onLeadingTap,
      this.onActionTap,
      required this.showLeading,
      required this.showAction});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.colorBlack, // Set your desired color here
    ));
    return AppBar(
      title: Text(title, style: AppStyles.homeHeadingColorDark),
      centerTitle: false,
      backgroundColor: AppColors.colorLight,
      elevation: 0.0,
      leading: showLeading
          ? InkWell(
              onTap: onLeadingTap ??
                  () {
                    Navigator.pop(context);
                  },
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: SvgPicture.asset(AppImageConstants.backButtonIcon,
                    height: 24, width: 24),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
