
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osb/pages/employee/employee_details_bottom_sheet.dart';

import '../../common/styles/app_colors.dart';
import '../../common/styles/app_styles.dart';
import '../../common/utils/constant.dart';
import '../../common/widgets/app_snackbar.dart';
import '../../model/base/base_response.dart';
import '../../model/employee/employee_model.dart';
import '../../repo/employee_detail_repo.dart';

class EmployeeUpdateBottomSheet extends StatefulWidget {

  final Employee employeeData;
  final VoidCallback onEmployeeListChanged;
  final void Function(Employee) onUpdateCalled;
  
  const EmployeeUpdateBottomSheet({
    super.key,
    required this.employeeData,
    required this.onEmployeeListChanged,
    required this.onUpdateCalled
  });

  @override
  _EmployeeUpdateBottomSheetState createState() => _EmployeeUpdateBottomSheetState(employeeData, onUpdateCalled);
}

class _EmployeeUpdateBottomSheetState extends State<EmployeeUpdateBottomSheet> {
  final Employee employeeData;
  final void Function(Employee) onUpdateCalled;

  _EmployeeUpdateBottomSheetState(this.employeeData, this.onUpdateCalled);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      constraints: BoxConstraints(maxHeight: 300),
          padding: EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: ListView(
              children: [
                updateButton(context),
                deleteButton(context),
                cancelButton(context)
              ]
          )
      
    );
  }

  
  GestureDetector updateButton(BuildContext pageContext) {
    return GestureDetector(
              onTap: (){
                Navigator.pop(context);
                onUpdateCalled(employeeData);
              },
              child:Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
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
                  Constants.update,
                  style: AppStyles.buttonTvStyle,
                ),
            )
          );
  }

  GestureDetector deleteButton(BuildContext pageContext) {
    return GestureDetector(
              onTap: (){
                deleteEmployee(pageContext);
              },
              child:Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                  Constants.delete,
                  style: AppStyles.buttonTvStyleColorDark,
                ),
            )
          );
  }

  GestureDetector cancelButton(BuildContext pageContext) {
    return GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                constraints: const BoxConstraints(
                  minHeight: 45),
                decoration: const BoxDecoration(
                  color: AppColors.colorGreyOut,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: const Text(
                  Constants.cancel,
                  style: AppStyles.buttonTvStyle,
                ),
            )
          );
  }

  void deleteEmployee(BuildContext pageContext) async {
    final BaseResponse deleteResponse = await EmployeeDetailRepo().deleteEmployee(employeeData.documentId);

    if (deleteResponse.statusCode == 200){
      AppSnackBar().showSnackbar(pageContext, deleteResponse.message ?? Constants.dashed, false);
      Navigator.pop(pageContext);
      widget.onEmployeeListChanged();
    }else{
      Navigator.pop(pageContext);
      AppSnackBar().showSnackbar(pageContext, deleteResponse.message ?? Constants.dashed, false);    
    }
    print('deleteEmployee');

  }

}
