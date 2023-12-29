import 'package:flutter/material.dart';
import 'package:osb/common/utils/converter_object.dart';
import 'package:osb/common/styles/app_colors.dart';
import 'package:osb/common/styles/app_styles.dart';
import 'package:osb/common/utils/constant.dart';
import 'package:osb/model/employee/employee_model.dart';
import '../../common/widgets/app_snackbar.dart';
import '../../model/base/base_response.dart';
import '../../repo/employee_detail_repo.dart';


class EmployeeDetailBottomSheet extends StatefulWidget {
  final VoidCallback onEmployeeListChanged;
  final String sheetOpenedFor;
  final Employee? employeeData;

  const EmployeeDetailBottomSheet(
    {super.key, 
    required this.onEmployeeListChanged,
    required this.sheetOpenedFor,
    this.employeeData
    }
  );


  @override
  _EmployeeDetailBottomSheetState createState() => _EmployeeDetailBottomSheetState(onEmployeeListChanged, employeeData, sheetOpenedFor);
}

class _EmployeeDetailBottomSheetState extends State<EmployeeDetailBottomSheet> {
  late TextEditingController employeeName = TextEditingController();
  late TextEditingController employeeSalary = TextEditingController();
  late int dateOfJoining;
  DateTime selectedDate = DateTime.now();
  bool isRoleListOpen = false;

  late Employee employeeDetails = Employee.withDefaults();
  final VoidCallback onSuccessfulChange;
  final Employee? employeeData;
  final String sheetOpenedFor;

  _EmployeeDetailBottomSheetState(this.onSuccessfulChange, this.employeeData, this.sheetOpenedFor);


  List<String> genderList = Constants.genderArray;
  List<String> roleList = Constants.roleArray;
  int selectedGender = 0;

  @override
  initState(){
    super.initState();
    if (sheetOpenedFor == SheetNames.edit){
      if (employeeData != null){
        employeeDetails = employeeData ?? Employee.withDefaults();
        employeeName.text = employeeData!.employeeName ?? Constants.dashed;
        employeeSalary.text = employeeData!.employeeSalary.toString();
        selectedGender = employeeData!.gender!;
        selectedDate = DateTime.fromMillisecondsSinceEpoch(employeeData!.dateOfJoining!);
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed to free up resources
    employeeName.dispose();
    employeeSalary.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          constraints: BoxConstraints(minHeight: 550),
          padding: EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Stack(
                children: [
                  ListView(
                    physics: isRoleListOpen ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                    children: [
                        fieldSpacer(15),
                        roleComponent(),
                        fieldSpacer(15),
                        nameComponent(),
                        fieldSpacer(15),
                        salaryComponent(),
                        fieldSpacer(15),
                        dojComponent(context),
                        fieldSpacer(15),
                        genderComponent(),
                        fieldSpacer(25),
                        bottomButtons(context),
                        fieldSpacer(25),
                    ],
                  ),
                  if (isRoleListOpen)
                    categoryDropDown()               
                  ,
                ]
              )
        );
  }

  Column roleComponent() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:5, bottom: 5),
                      child: Text(
                        '${Constants.role}${Constants.asterick}',
                        style: AppStyles.inputHeaderBlack12),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isRoleListOpen = true;
                          });
                        },
                        child: Container(
                        constraints: const BoxConstraints(maxHeight: 52),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            width: 1.5,
                            color: AppColors.colorGridLine,
                          ),
                        ),
                        child: Text(
                          employeeDetails.employeeRole == null ? Constants.enterRole : employeeDetails.employeeRole ?? Constants.dashed,
                          style: employeeDetails.employeeRole == null ? AppStyles.inputHintTvStyle : AppStyles.inputTvStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
  }

  Column nameComponent() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:5, bottom: 5),
                      child: Text(
                        '${Constants.employeeName}${Constants.asterick}',
                        style: AppStyles.inputHeaderBlack12),
                    ),
                    SizedBox(
                      child: TextField(
                        controller: employeeName,
                        style: AppStyles.inputTvStyle,
                        decoration: const InputDecoration(
                          hintText: Constants.enterEmployeeName,
                          hintStyle: AppStyles.inputHintTvStyle,
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColors.colorGridLine, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColors.colorGridLine, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
  }

  Column salaryComponent() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:5, bottom: 5),
                      child: Text(
                        '${Constants.salaryDay}${Constants.asterick}',
                        style: AppStyles.inputHeaderBlack12),
                    ),
                    SizedBox(
                      child: TextField(
                        controller: employeeSalary,
                        style: AppStyles.inputTvStyle,
                        decoration: const InputDecoration(
                          hintText: Constants.enterSalary,
                          hintStyle: AppStyles.inputHintTvStyle,
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColors.colorGridLine, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColors.colorGridLine, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
  }

  Column dojComponent(BuildContext context) {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:5, bottom: 5),
                      child: Text(
                        '${Constants.dateOfJoining}${Constants.asterick}',
                        style: AppStyles.inputHeaderBlack12),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            width: 1.5,
                            color: AppColors.colorGridLine,
                          ),
                        ),
                        child: Text(
                          employeeDetails.dateOfJoining == null ? Constants.enterDateOfJoin : ConverterObject.milliToDateConverter(selectedDate.millisecondsSinceEpoch),
                          style: employeeDetails.dateOfJoining == null ? AppStyles.inputHintTvStyle : AppStyles.inputTvStyle,
                          ),
                        ),
                      ) 
                    ),
                  ],
                );
  }

  Column genderComponent() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:5, bottom: 10),
                      child: Text(
                        '${Constants.gender}${Constants.asterick}',
                        style: AppStyles.inputHeaderBlack12),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        radioButton(genderList[0], 0),
                        const SizedBox(width: 15),
                        radioButton(genderList[1], 1),
                      ],
                    ),
                  ],
                );
  }

  SizedBox fieldSpacer(double space) => SizedBox(height: space);

  Positioned categoryDropDown() {
    return Positioned(
                    top: 85,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.colorShadow.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 0.0
                          )
                        ]
                      ),
                      height: 150,
                      child: categoryListComponent(),
                    ),
                  );
  }

  ListView categoryListComponent() => ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: roleList.length,
    separatorBuilder: (context, index) => const SizedBox(height: 1,
    child: Divider(
      color: AppColors.colorGridLine,
      thickness: 1.5,
    ),), 
    itemBuilder: (BuildContext context, int index)
      {  
        return GestureDetector(
          onTap: (){
              setState(() {
                employeeDetails.employeeRole = roleList[index];
                isRoleListOpen = false;
              });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            color: AppColors.colorWhite,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Text(roleList[index],
              style: AppStyles.bodyMediumBlack14,),
            )
          ),
        );
        
      }

  );

  Widget radioButton(String name, int index) => GestureDetector(
    onTap: (){
      setState(() {
        selectedGender = index;
        employeeDetails.gender = index;
      });
    },
    child: Container(
        constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selectedGender == index ? AppColors.colorDark : AppColors.colorWhite,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: AppColors.colorDark,
            width: 1
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Text(name,
            style: TextStyle(
              fontSize: 14,
              color: selectedGender == index ? AppColors.colorWhite : AppColors.colorDark,
            )
          ),
        ),
        
      )
  );

  SizedBox bottomButtons(BuildContext pageContext) => SizedBox(
      child: Row(
        children: [
          Expanded(
            flex: 1, 
            child: GestureDetector(
              onTap: (){
                addEmployee(pageContext);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                constraints: const BoxConstraints(
                                  minHeight: 45),
                                decoration: const BoxDecoration(
                                  color: AppColors.colorBlack,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: const Text(
                                  Constants.submit,
                                  style: AppStyles.buttonTvStyle,
                                ),
                              )
              ) 
          ),
          Expanded(
            flex: 1, 
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                constraints: const BoxConstraints(
                  minHeight: 45),
                decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: AppColors.colorDark,
                    width: 2
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: const Text(
                  Constants.cancel,
                  style: AppStyles.buttonTvStyleColorDark,
                ),
              )
            ) 
          ),                
          ],
        ),
    );
                
  void addEmployee(BuildContext pageContext) async {
    if (validateData()){  
      if (sheetOpenedFor == SheetNames.add){
        final BaseResponse addResponse = await EmployeeDetailRepo().createEmployee(employeeDetails);
        if (addResponse.statusCode == 200){
          AppSnackBar().showSnackbar(pageContext, addResponse.message ?? Constants.dashed, false);
          widget.onEmployeeListChanged();
          Navigator.pop(pageContext);
        }else{
          Navigator.pop(pageContext);
          AppSnackBar().showSnackbar(pageContext, addResponse.message ?? Constants.dashed, false);    
        }
      }else{
        final BaseResponse addResponse = await EmployeeDetailRepo().updateEmployee(employeeDetails);
        if (addResponse.statusCode == 200){
          AppSnackBar().showSnackbar(pageContext, addResponse.message ?? Constants.dashed, false);
          widget.onEmployeeListChanged();
          Navigator.pop(pageContext);
        }else{
          Navigator.pop(pageContext);
          AppSnackBar().showSnackbar(pageContext, addResponse.message ?? Constants.dashed, false);    
        }
      }   
      

    }        
  }
    
  bool validateData() {
    
    if (employeeDetails.employeeRole == null){
      return false;   
    }
    if (employeeName.text.isEmpty){
      return false;   
    }

    if (employeeSalary.text.isEmpty){
      return false;  
    }

    if (employeeDetails.dateOfJoining == null){
      return false; 
    }

    employeeDetails.employeeName = employeeName.text;
    employeeDetails.employeeSalary = int.parse(employeeSalary.text);
    employeeDetails.gender = selectedGender;
    return true;

  }
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) => 
      Theme(
        data: ThemeData(
          primaryColor: AppColors.colorDark,
          colorScheme: const ColorScheme.light(primary: AppColors.colorDark),
          ), 
        child: child!),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        print('date ${picked}');
        selectedDate = picked;
        employeeDetails.dateOfJoining = picked.millisecondsSinceEpoch;
      });
    }
  }

}
