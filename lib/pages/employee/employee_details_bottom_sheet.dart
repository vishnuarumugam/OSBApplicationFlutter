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
  _EmployeeDetailBottomSheetState createState() => _EmployeeDetailBottomSheetState(onEmployeeListChanged);
}

class _EmployeeDetailBottomSheetState extends State<EmployeeDetailBottomSheet> {
  late TextEditingController employeeName = TextEditingController();
  late TextEditingController employeeSalary = TextEditingController();
  late int dateOfJoining;
  DateTime _selectedDate = DateTime.now();
  bool isCategoryListOpen = false;

  late Employee employeeDetails = Employee.withDefaults();
  final VoidCallback onSuccessfulChange;
  _EmployeeDetailBottomSheetState(this.onSuccessfulChange);


  List<String> genderList = Constants.genderArray;
  List<String> categoryList = Constants.categoryArray;
  int selectedGender = 0;

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
                    physics: isCategoryListOpen ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                    children: [
                        fieldSpacer(15),
                        categoryComponent(),
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
                  if (isCategoryListOpen)
                    categoryDropDown()               
                  ,
                ]
              )
        );
  }

  Column categoryComponent() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:5, bottom: 5),
                      child: Text(
                        '${Constants.category}${Constants.asterick}',
                        style: AppStyles.inputHeaderBlack12),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isCategoryListOpen = true;
                          });
                        },
                        child: Container(
                        constraints: BoxConstraints(maxHeight: 52),
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
                          employeeDetails.employeeCategory == null ? Constants.enterCategory : employeeDetails.employeeCategory ?? Constants.dashed,
                          style: employeeDetails.employeeCategory == null ? AppStyles.inputHintTvStyle : AppStyles.inputHeaderBlack12,
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
                          employeeDetails.dateOfJoining == null ? Constants.enterDateOfJoin : ConverterObject.milliToDateConverter(_selectedDate.millisecondsSinceEpoch),
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
    itemCount: categoryList.length,
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
                employeeDetails.employeeCategory = categoryList[index];
                isCategoryListOpen = false;
              });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            color: AppColors.colorWhite,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Text(categoryList[index],
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
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
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
          Expanded(
            flex: 1, 
            child: GestureDetector(
              onTap: (){
                addEmployee(pageContext);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
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
                                  Constants.add,
                                  style: AppStyles.buttonTvStyle,
                                ),
                              )
              ) 
            )
                          
          ],
        ),
    );
                
  void addEmployee(BuildContext pageContext) async {
    if (validateData()){      
      final BaseResponse addResponse = await EmployeeDetailRepo().createEmployee(employeeDetails);
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
    
  bool validateData() {
    
    if (employeeDetails.employeeCategory == null){
      print('employeeCategory error'); 
      return false;   
    }
    if (employeeName.text.isEmpty){
      print('employeeName error'); 
      return false;   
    }

    if (employeeSalary.text.isEmpty){
      print('employeeSalary error'); 
      return false;  
    }

    if (employeeDetails.dateOfJoining == null){
      print('dateOfJoining error'); 
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
      initialDate: DateTime.now(),
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

    if (picked != null && picked != _selectedDate) {
      setState(() {
        print('date ${picked}');
        _selectedDate = picked;
        employeeDetails.dateOfJoining = picked.millisecondsSinceEpoch;
      });
    }
  }

}
