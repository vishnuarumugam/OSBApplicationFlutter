import '../../../app/app.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 8, backgroundColor: AppColors.colorLight),
      body: Container(
        color: AppColors.colorDarkBg,
        child: ListView(
          children: [topDesign(), bottomDesign(context)],
        ),
      ),
    );
  }

  Container bottomDesign(BuildContext pageContext) => Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(AppStringConstants.labours,
                  style: AppStyles.bodyHeaderBlack14),
            ),
            labourContainer(pageContext),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(AppStringConstants.dining,
                  style: AppStyles.bodyHeaderBlack14),
            ),
            diningContainer(pageContext),
          ]),
        ),
      );

  Container diningContainer(BuildContext pageContext) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorShadow.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5.0,
              offset: const Offset(0, 5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pushToScreen(pageContext, const DineInPage());
            },
            child: Container(
              width: 100,
              color: AppColors.colorWhite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 4),
                      child: SvgPicture.asset(AppImageConstants.dineInIcon,
                          height: 30, width: 30),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 8),
                      child: Text(
                        AppStringConstants.dineIn,
                        style: AppStyles.bodyRegularBlack12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    )
                  ]),
            ),
          ),
          const VerticalDivider(
            color: AppColors.colorGreyOut,
            indent: 10,
            endIndent: 10,
            thickness: 0.8,
          ),
          GestureDetector(
            onTap: () {
              pushToScreen(pageContext, const MenuPage());
            },
            child: Container(
                width: 100,
                color: AppColors.colorWhite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 4),
                        child: SvgPicture.asset(AppImageConstants.menuIcon,
                            height: 30, width: 30),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 4, left: 8, right: 8, bottom: 8),
                        child: Text(
                          AppStringConstants.menu,
                          style: AppStyles.bodyRegularBlack12,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      )
                    ])),
          ),
          const VerticalDivider(
            color: AppColors.colorGreyOut,
            indent: 10,
            endIndent: 10,
            thickness: 0.8,
          ),
          GestureDetector(
            onTap: () {
              pushToScreen(pageContext, const TablePage());
            },
            child: Container(
              width: 100,
              color: AppColors.colorWhite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 4),
                      child: SvgPicture.asset(AppImageConstants.tablesIcon,
                          height: 30, width: 30),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 8),
                      child: Text(
                        AppStringConstants.table,
                        style: AppStyles.bodyRegularBlack12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Container labourContainer(BuildContext pageContext) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorShadow.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5.0,
              offset: const Offset(0, 5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pushToScreen(pageContext, const EmployeePage());
            },
            child: Container(
              width: 100,
              color: AppColors.colorWhite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 4),
                      child: SvgPicture.asset(AppImageConstants.membersIcon,
                          height: 30, width: 30),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 8),
                      child: Text(
                        AppStringConstants.employees,
                        style: AppStyles.bodyRegularBlack12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    )
                  ]),
            ),
          ),
          const VerticalDivider(
            color: AppColors.colorGreyOut,
            indent: 10,
            endIndent: 10,
            thickness: 0.8,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                width: 100,
                color: AppColors.colorWhite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 4),
                        child: SvgPicture.asset(AppImageConstants.bonusIcon,
                            height: 30, width: 30),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 4, left: 8, right: 8, bottom: 8),
                        child: Text(
                          AppStringConstants.bonus,
                          style: AppStyles.bodyRegularBlack12,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      )
                    ])),
          ),
          const VerticalDivider(
            color: AppColors.colorGreyOut,
            indent: 10,
            endIndent: 10,
            thickness: 0.8,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100,
              color: AppColors.colorWhite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 4),
                      child: SvgPicture.asset(AppImageConstants.attendanceIcon,
                          height: 30, width: 30),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 8),
                      child: Text(
                        AppStringConstants.attendance,
                        style: AppStyles.bodyRegularBlack12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Container topDesign() => Container(
        decoration: BoxDecoration(
            color: AppColors.colorLight,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 0.0)
            ]),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: SvgPicture.asset(AppImageConstants.foodBowlClosedIcon,
                    height: 60, width: 60),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStringConstants.om,
                    style: AppStyles.headingSacColorDark24,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  Text(
                    AppStringConstants.saravanaBhavan.toUpperCase(),
                    style: AppStyles.homeHeadingColorDark,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  )
                ],
              )
            ]),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/boy_cook.png',
                    height: 180,
                    width: 180,
                  ),
                  const Text(AppStringConstants.tasteOfHome,
                      style: AppStyles.headingSacBlack36)
                ],
              ),
            )
          ],
        ),
      );
}
