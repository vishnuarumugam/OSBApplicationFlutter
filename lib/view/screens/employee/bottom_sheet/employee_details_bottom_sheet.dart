import '../../../../app/app.dart';

class EmployeeDetailBottomSheet extends StatefulWidget {
  final VoidCallback onEmployeeListChanged;
  final String sheetOpenedFor;
  final Employee? employeeData;

  const EmployeeDetailBottomSheet(
      {super.key,
      required this.onEmployeeListChanged,
      required this.sheetOpenedFor,
      this.employeeData});

  @override
  _EmployeeDetailBottomSheetState createState() =>
      _EmployeeDetailBottomSheetState(
          onEmployeeListChanged, employeeData, sheetOpenedFor);
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

  _EmployeeDetailBottomSheetState(
      this.onSuccessfulChange, this.employeeData, this.sheetOpenedFor);

  List<String> genderList = AppStringConstants.genderArray;
  List<String> roleList = AppStringConstants.roleArray;
  int selectedGender = 0;

  @override
  initState() {
    super.initState();
    if (sheetOpenedFor == SheetNames.edit) {
      if (employeeData != null) {
        employeeDetails = employeeData ?? Employee.withDefaults();
        employeeName.text =
            employeeData!.employeeName ?? AppStringConstants.dashed;
        employeeSalary.text = employeeData!.employeeSalary.toString();
        selectedGender = employeeData!.gender!;
        selectedDate =
            DateTime.fromMillisecondsSinceEpoch(employeeData!.dateOfJoining!);
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

  createEmployee() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<EmployeeViewModel>(context, listen: false)
              .createEmployee(employeeDetails);
      if (response.statusCode == 200) {
        widget.onEmployeeListChanged();
      }
      Navigator.pop(context);
      showToast(context, response.message);
      hideLoader();
    } catch (error) {
      hideLoader();
      rethrow;
    }
  }

  updateEmployee() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<EmployeeViewModel>(context, listen: false)
              .updateEmployee(employeeDetails);
      if (response.statusCode == 200) {
        widget.onEmployeeListChanged();
      }
      Navigator.pop(context);
      hideLoader();
      showToast(context, response.message);
    } catch (error) {
      hideLoader();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      extendBody: false,
      bottomNavigationBar: bottomButtons(context),
      body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
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
                ],
              ),
              if (isRoleListOpen) categoryDropDown(),
            ]),
          )),
    );
  }

  Column roleComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.role}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: GestureDetector(
            onTap: () {
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
                employeeDetails.employeeRole == null
                    ? AppStringConstants.enterRole
                    : employeeDetails.employeeRole ?? AppStringConstants.dashed,
                style: employeeDetails.employeeRole == null
                    ? AppStyles.inputHintTvStyle
                    : AppStyles.inputTvStyle,
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
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.employeeName}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: employeeName,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.enterEmployeeName,
              hintStyle: AppStyles.inputHintTvStyle,
              fillColor: AppColors.colorWhite,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
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
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.salaryDay}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: employeeSalary,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.enterSalary,
              hintStyle: AppStyles.inputHintTvStyle,
              fillColor: AppColors.colorWhite,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: AppColors.colorGridLine, width: 1.5),
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
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.dateOfJoining}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
            child: GestureDetector(
          onTap: () {
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
              employeeDetails.dateOfJoining == null
                  ? AppStringConstants.enterDateOfJoin
                  : ConverterObject.milliToDateConverter(
                      selectedDate.millisecondsSinceEpoch),
              style: employeeDetails.dateOfJoining == null
                  ? AppStyles.inputHintTvStyle
                  : AppStyles.inputTvStyle,
            ),
          ),
        )),
      ],
    );
  }

  Column genderComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
              '${AppStringConstants.gender}${AppStringConstants.asterick}',
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

  Positioned categoryDropDown() {
    return Positioned(
      top: 85,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorShadow.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 0.0)
            ]),
        height: 200,
        child: categoryListComponent(),
      ),
    );
  }

  ListView categoryListComponent() => ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: roleList.length,
      separatorBuilder: (context, index) => const SizedBox(
            height: 1,
            child: Divider(
              color: AppColors.colorGridLine,
              thickness: 1.5,
            ),
          ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
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
                child: Text(
                  roleList[index],
                  style: AppStyles.bodyMediumBlack14,
                ),
              )),
        );
      });

  Widget radioButton(String name, int index) => GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = index;
          employeeDetails.gender = index;
        });
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selectedGender == index
                ? AppColors.colorDark
                : AppColors.colorWhite,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: AppColors.colorDark, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Text(name,
              style: TextStyle(
                fontSize: 14,
                color: selectedGender == index
                    ? AppColors.colorWhite
                    : AppColors.colorDark,
              )),
        ),
      ));

  Container bottomButtons(BuildContext pageContext) => Container(
        height: 80,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: AppColors.colorWhite, boxShadow: [
          BoxShadow(
            color: AppColors.colorGreyOut.withOpacity(0.9),
            offset: const Offset(0, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ]),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      constraints: const BoxConstraints(minHeight: 45),
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        shape: BoxShape.rectangle,
                        border:
                            Border.all(color: AppColors.colorDark, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Text(
                        AppStringConstants.cancel,
                        style: AppStyles.buttonTvStyleColorDark,
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      addEmployee(pageContext);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      constraints: const BoxConstraints(minHeight: 45),
                      decoration: const BoxDecoration(
                        color: AppColors.colorBlack,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Text(
                        AppStringConstants.submit,
                        style: AppStyles.buttonTvStyle,
                      ),
                    ))),
          ],
        ),
      );

  void addEmployee(BuildContext pageContext) async {
    if (validateData()) {
      if (sheetOpenedFor == SheetNames.add) {
        createEmployee();
      } else {
        updateEmployee();
      }
    }
  }

  bool validateData() {
    if (employeeDetails.employeeRole == null) {
      return false;
    }
    if (employeeName.text.isEmpty) {
      return false;
    }

    if (employeeSalary.text.isEmpty) {
      return false;
    }

    if (employeeDetails.dateOfJoining == null) {
      return false;
    }

    employeeDetails.employeeName = employeeName.text;
    employeeDetails.employeeSalary = int.parse(employeeSalary.text);
    employeeDetails.gender = selectedGender;
    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await displayDatePicker(context, selectedDate);

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        employeeDetails.dateOfJoining = picked.millisecondsSinceEpoch;
      });
    }
  }
}
