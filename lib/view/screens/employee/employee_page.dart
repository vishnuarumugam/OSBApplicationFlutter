import '../../../app/app.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  Future<List<Employee>>? employeeListResponse;
  String totalEmployee = AppStringConstants.dashed;
  String menEmployee = AppStringConstants.dashed;
  String womenEmployee = AppStringConstants.dashed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        showLeading: true,
        showAction: false,
        title: AppStringConstants.employees,
      ),
      body: ListView(
        children: [
          topDesign(),
          bottomDesign(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorDark,
        shape: const CircleBorder(),
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    employeeListResponse = getEmployees();
  }

  Future<List<Employee>> getEmployees() async {
    var employeeList =
        await Provider.of<EmployeeViewModel>(context, listen: false)
            .getEmployees();
    var menCount = 0;
    var womenCount = 0;

    if (employeeList.isNotEmpty) {
      for (var employee in employeeList) {
        if (employee.gender == 0) {
          menCount += 1;
        } else {
          womenCount += 1;
        }
      }

      setState(() {
        totalEmployee = employeeList.length.toString();
        menEmployee = menCount.toString();
        womenEmployee = womenCount.toString();
      });
    }

    return employeeList;
  }

  FutureBuilder fetchEmployeeListComponent() => FutureBuilder<List<Employee>>(
      future: employeeListResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final data = snapshot.data;
          if (data != null && data.isNotEmpty) {
            return employeeListComponent(data);
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              child: const Center(
                child: Text(
                  AppStringConstants.noEmployees,
                  style: AppStyles.bodyMessageColorDark14,
                ),
              ),
            );
          }
        }
      });

  ListView employeeListComponent(List<Employee>? employeeData) =>
      ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: employeeData!.length,
          separatorBuilder: (context, index) => const SizedBox(
                height: 1,
                child: Divider(
                  color: AppColors.colorDark,
                  thickness: 1.5,
                ),
              ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  _showUpdateBottomSheet(context, employeeData[index]);
                },
                child: Container(
                  width: double.infinity,
                  color: AppColors.colorLight,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 5, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  AppImageConstants.profileIcon,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        employeeData[index].employeeName ??
                                            AppStringConstants.dashed,
                                        style: AppStyles.bodyHeaderBlack14,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        '${AppStringConstants.workingFrom}${ConverterObject.milliToDateConverter(employeeData[index].dateOfJoining)}',
                                        style: AppStyles.bodyRegularBlack12,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    )
                                  ]),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 12, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  AppImageConstants.rupeeIcon,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        '${employeeData[index].employeeSalary}${AppStringConstants.perDay}',
                                        style: AppStyles.bodyHeaderBlack14,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        employeeData[index].employeeRole ??
                                            AppStringConstants.dashed,
                                        style: AppStyles.bodyRegularBlack12,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    )
                                  ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });

  Container bottomDesign() => Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(AppStringConstants.employees,
                    style: AppStyles.bodyRegularBlack12)),
            const SizedBox(height: 7),
            fetchEmployeeListComponent()
          ],
        ),
      );

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
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  labourContainer(),
                  Image.asset(
                    AppImageConstants.employeeIcon,
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
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 10, right: 10, bottom: 4),
                child: Text(
                  totalEmployee,
                  style: AppStyles.bodySemiBoldColorDark14,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 8),
                child: Text(
                  AppStringConstants.total,
                  style: AppStyles.bodyRegularBlack12,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              )
            ]),
            const VerticalDivider(
              color: AppColors.colorGreyOut,
              indent: 10,
              endIndent: 10,
              thickness: 0.8,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 10, right: 10, bottom: 4),
                child: Text(
                  menEmployee,
                  style: AppStyles.bodySemiBoldColorDark14,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 8),
                child: Text(
                  AppStringConstants.men,
                  style: AppStyles.bodyRegularBlack12,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              )
            ]),
            const VerticalDivider(
              color: AppColors.colorGreyOut,
              indent: 10,
              endIndent: 10,
              thickness: 0.8,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 10, right: 10, bottom: 4),
                child: Text(
                  womenEmployee,
                  style: AppStyles.bodySemiBoldColorDark14,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 8),
                child: Text(
                  AppStringConstants.women,
                  style: AppStyles.bodyRegularBlack12,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              )
            ]),
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
            onEmployeeListChanged: _handleEmployeeListModified,
            sheetOpenedFor: SheetNames.add,
            employeeData: null);
      },
    );
  }

  void _showUpdateBottomSheet(BuildContext context, Employee employee) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmployeeUpdateBottomSheet(
            employeeData: employee,
            onEmployeeListChanged: _handleEmployeeListModified,
            onUpdateCalled: _handleUpdateCallback);
      },
    );
  }

  void _handleEmployeeListModified() {
    employeeListResponse = getEmployees();
    setState(() {});
  }

  void _handleUpdateCallback(Employee employee) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmployeeDetailBottomSheet(
            onEmployeeListChanged: _handleEmployeeListModified,
            sheetOpenedFor: SheetNames.edit,
            employeeData: employee);
      },
    );
  }
}
