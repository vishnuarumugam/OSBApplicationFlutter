import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osb/common/converter_object.dart';
import 'package:osb/common/app_bar.dart';
import 'package:osb/common/app_colors.dart';
import 'package:osb/common/app_styles.dart';
import 'package:osb/common/constant.dart';
import 'package:osb/employee/employee_details_bottom_sheet.dart';
import 'package:osb/model/employee_model.dart';

class EmployeePage extends StatelessWidget{
  EmployeePage({super.key});

  List<Employee> employees = [];

  void _getEmployees(){
    employees = Employee.getEmployees();
  }
  @override
  Widget build(BuildContext context) {
    _getEmployees();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.colorBlack, // Set your desired color here
    ));
    return Scaffold(
      appBar: CommonAppBar(
            onLeadingTap: (){
              Navigator.pop(context);
            },
            onActionTap: (){},
            showLeading: true,
            showAction: false,
            title: Constants.employees,
          ),
      body: ListView(
          children: [
            topDesign(),
            bottomDesign(),
          ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorDark,
        shape: CircleBorder(),
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }


  Container bottomDesign() => Container(
    margin: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height:15),
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            Constants.employees,
            style: AppStyles.bodyRegularBlack12
          )
        ),
        const SizedBox(height:7),      
        employeeListComponent()

      ],
    ),
  );

  ListView employeeListComponent() => ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: employees.length,
    separatorBuilder: (context, index) => const SizedBox(height: 1,
    child: Divider(
      color: AppColors.colorDark,
      thickness: 1.5,
    ),), 
    itemBuilder: (BuildContext context, int index)
      {  
        return Container(
          width: double.infinity,
          color: AppColors.colorLight,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 5, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset('assets/icons/profile.svg',
                        height: 24,
                        width: 24,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(employees[index].employeeName ?? Constants.dashed ,
                            style: AppStyles.bodyMediumBlack14,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('${Constants.workingFrom}${ConverterObject.milliToDateConverter(employees[index].dateOfJoining)}', 
                            style: AppStyles.bodyRegularBlack12,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,),
                          )
                        ]
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 12, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset('assets/icons/rupee.svg',
                        height: 24,
                        width: 24,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('${employees[index].employeeSalary}${Constants.perDay}', 
                            style: AppStyles.bodyMediumBlack14,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(employees[index].employeeCategory ?? Constants.dashed , 
                            style: AppStyles.bodyRegularBlack12,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,),
                          )
                        ]
                      ),
                    ],
                  ),
                ),
              ],
              ),
          ),
        );
      }

  );

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
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labourContainer(),
              Image.asset('assets/icons/employees.png',
                height: 155,
                width: 150,
              ),
            ],
          ),
        )
      ],
    ),
  );

  Container labourContainer() {
    return Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:8, left:10, right:10, bottom:4),
                              child: Text(
                                '4',
                                style: AppStyles.bodySemiBoldColorDark14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:4, left:10, right:10, bottom:8),
                              child: Text(
                                Constants.total,
                                style: AppStyles.bodyRegularBlack12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            )
                          ]
                        ),
                    const VerticalDivider(
                        color: AppColors.colorGreyOut,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.8,
                    ),
                    const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:8, left:10, right:10, bottom:4),
                              child: Text(
                                '3',
                                style: AppStyles.bodySemiBoldColorDark14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:4, left:10, right:10, bottom:8),
                              child: Text(
                                Constants.men,
                                style: AppStyles.bodyRegularBlack12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            )
                          ]
                        ),
                    const VerticalDivider(
                        color: AppColors.colorGreyOut,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.8,
                    ),
                    const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:8, left:10, right:10, bottom:4),
                              child: Text(
                                '1',
                                style: AppStyles.bodySemiBoldColorDark14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:4, left:10, right:10, bottom:8),
                              child: Text(
                                Constants.women,
                                style: AppStyles.bodyRegularBlack12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            )
                          ]
                        ),
                  ],
                            ),
              ),
            );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmployeeDetailBottomSheet(
          (){
            print("add button clicked");
          }
        );
      },
    );
  }

}