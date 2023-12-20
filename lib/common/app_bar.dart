import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osb/common/app_colors.dart';
import 'package:osb/common/app_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback onLeadingTap;
  final VoidCallback onActionTap;
  final bool showLeading;
  final bool showAction;

  const CommonAppBar({super.key, 
    required this.title,
    required this.onLeadingTap,
    required this.onActionTap,
    required this.showLeading,
    required this.showAction
  });

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.colorBlack, // Set your desired color here
    ));
    return  AppBar(
      title: Text(title,
      style: AppStyles.homeHeadingColorDark),
      centerTitle: false,
      backgroundColor: AppColors.colorLight,
      elevation: 0.0,
      leading: showLeading ? GestureDetector(
          onTap: onLeadingTap,
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/left_arrow.svg',
            height: 24,
            width: 24),
          ),
        ) : null,
    );
    }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
}