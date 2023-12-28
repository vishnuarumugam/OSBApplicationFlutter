
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osb/common/styles/app_colors.dart';
import 'package:osb/common/styles/app_styles.dart';
import 'package:osb/common/utils/constant.dart';
import 'package:osb/pages/employee/employee_page.dart';

class DashboardPage extends StatelessWidget{
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.colorBlack, // Set your desired color here
    ));

    return Scaffold(
      body: Container(
        color: AppColors.colorDark,
        child: ListView(
          children: [
            topDesign(),   
            bottomDesign(context) 
          ],
        ),
      ),
    );
  }

  Container bottomDesign(BuildContext pageContext) => Container(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:20),
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                    Constants.labours,
                    style: AppStyles.bodyHeaderBlack14),
              ),
              labourContainer(pageContext),
        ]
      ),
      ),
  );

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
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                        navigateToEmployeePage(pageContext);
                      },
                      child: Container(
                        width: 100,
                        color: AppColors.colorWhite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8, left:8, right:8, bottom:4),
                              child: SvgPicture.asset('assets/icons/members.svg',
                              height: 30,
                              width: 30),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top:4, left:8, right:8, bottom:8),
                              child: Text(
                                Constants.employees,
                                style: AppStyles.bodyRegularBlack12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            )
                          ]
                        ),
                      ),
                  ),
                  const VerticalDivider(
                      color: AppColors.colorGreyOut,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.8,
                  ),
                  GestureDetector(
                      onTap: (){
                        navigateToBonusPage(pageContext);
                      },
                      child: Container(
                        width: 100,
                        color: AppColors.colorWhite,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8, left:8, right:8, bottom:4),
                            child: SvgPicture.asset('assets/icons/bonus.svg',
                            height: 30,
                            width: 30),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:4, left:8, right:8, bottom:8),
                            child: Text(
                              Constants.bonus,
                              style: AppStyles.bodyRegularBlack12,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          )
                        ])
                      ),
                  ),
                  const VerticalDivider(
                      color: AppColors.colorGreyOut,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.8,
                  ),
                  GestureDetector(
                      onTap: (){
                        navigateToAttendancePage(pageContext);
                      },
                      child: Container(
                        width: 100,
                        color: AppColors.colorWhite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8, left:8, right:8, bottom:4),
                              child: SvgPicture.asset('assets/icons/attendance.svg',
                              height: 30,
                              width: 30),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top:4, left:8, right:8, bottom:8),
                              child: Text(
                                Constants.attendance,
                                style: AppStyles.bodyRegularBlack12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            )
                          ]
                        ),
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
        bottomRight: Radius.circular(20)
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.colorShadow.withOpacity(0.3),
          blurRadius: 30,
          spreadRadius: 0.0
        )
      ]
    ),
    child: Column(
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: SvgPicture.asset('assets/icons/food_bowl_closed.svg',
                  height: 60,
                  width: 60
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Constants.om,
                  style: AppStyles.headingSacColorDark24,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  ),
                Text(
                  Constants.saravanaBhavan.toUpperCase(),
                  style: AppStyles.homeHeadingColorDark,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,)
              ],
            )
          ]
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/boy_cook.png',
                height: 180,
                width: 180,
              ),
              const Text(
                Constants.tasteOfHome,
                style: AppStyles.headingSacBlack36)
            ],
          ),
        )
      ],
    ),
  );
          
  void navigateToEmployeePage(BuildContext pageContext){
      print('navigateToEmployeePage');
      Navigator.push(
      pageContext, 
      MaterialPageRoute(builder: (context) =>
      EmployeePage())
    );
  }

  void navigateToBonusPage(BuildContext pageContext){

  }

  void navigateToAttendancePage(BuildContext pageContext){

  }
}