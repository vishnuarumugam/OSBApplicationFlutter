import 'package:flutter/material.dart';
import 'package:osb/common/converter_object.dart';
import 'package:osb/common/app_colors.dart';
import 'package:osb/common/app_styles.dart';
import 'package:osb/common/constant.dart';
import 'package:osb/common/utils.dart';
import 'package:osb/firebase/firebase_firestore_service.dart';
import 'package:osb/model/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EmployeeDetailBottomSheet extends StatefulWidget {
  final VoidCallback onSuccessfulChange;

  const EmployeeDetailBottomSheet(this.onSuccessfulChange, {super.key});


  @override
  _EmployeeDetailBottomSheetState createState() => _EmployeeDetailBottomSheetState(onSuccessfulChange);
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
                        const SizedBox(height: 15),
                        Column(
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
                        ),
                        const SizedBox(height: 15),
                        Column(
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
                        ),
                        const SizedBox(height: 15),
                        Column(
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
                        ),
                        const SizedBox(height: 15),
                        Column(
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
                        ),
                        const SizedBox(height: 15),
                        Column(
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
                        ),
                        const SizedBox(height: 25),
                        bottomButtons(context),
                        const SizedBox(height: 25),
                    ],
                  ),
                  if (isCategoryListOpen)
                    categoryDropDown()               
                  ,
                ]
              )
        );
  }

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
    // final firebaseService = FirebaseFirestoreService('employeeDetails');

    // print('firebaseService ${firebaseService}');
    


    if (validateData()){
      // await firebaseService.addDocument(employeeDetails);
      
      
      print('valid data ${employeeDetails.dateOfJoining}');
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
