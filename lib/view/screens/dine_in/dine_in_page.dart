import '../../../app/app.dart';

class DineInPage extends StatefulWidget {
  const DineInPage({super.key});

  @override
  State<DineInPage> createState() => _DineInPageState();
}

class _DineInPageState extends State<DineInPage> {
  Set<DineInEnum> segmentSelection = <DineInEnum>{DineInEnum.activeOrders};
  List<OrderDetail> orderListResponse = [];
  Future<List<OrderDetail>>? orderList;

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  Future<void> getOrder() async {
    //showLoader(context);
    var orderDetailList =
        await Provider.of<DineInPageViewModel>(context, listen: false)
            .getOrders();
    if (orderDetailList.isNotEmpty) {
      orderListResponse = orderDetailList;
      orderList = Future.value(orderDetailList);
    } else {
      orderListResponse = [];
      orderList = Future.value([]);
    }
    //hideLoader();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        showLeading: true,
        showAction: false,
        title: AppStringConstants.dineIn,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorDark,
        shape: const CircleBorder(),
        onPressed: () {
          pushToScreen(context, const AddNewOrderPage());
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.center,
              child: AppSegmentedButton<DineInEnum>(
                width: (MediaQuery.of(context).size.width) * 0.9,
                selected: segmentSelection,
                buttonSize: ButtonSize.small,
                selectedBackgroundColor: AppColors.colorDark,
                selectedTextColor: AppColors.colorWhite,
                unSelectedBackgroundColor: AppColors.colorWhite,
                unSelectedTextColor: AppColors.colorDark,
                onSelectionChanged: (newSelection) {
                  segmentSelection = newSelection;
                  setState(() {});
                },
                showSelectedIcon: false,
                segments: const <ButtonSegment<DineInEnum>>[
                  ButtonSegment<DineInEnum>(
                      value: DineInEnum.activeOrders,
                      label: Text(AppStringConstants.activeOrders,
                          overflow: TextOverflow.ellipsis, maxLines: 1)),
                  ButtonSegment<DineInEnum>(
                      value: DineInEnum.openBills,
                      label: Text(AppStringConstants.openBills,
                          overflow: TextOverflow.ellipsis, maxLines: 1)),
                  // if (false)
                  ButtonSegment<DineInEnum>(
                      value: DineInEnum.closedBills,
                      label: Text(AppStringConstants.closedBills,
                          overflow: TextOverflow.ellipsis, maxLines: 1)),
                ],
              ),
            ),
            fetchOrderListComponent()
          ],
        ),
      ),
    );
  }

  FutureBuilder fetchOrderListComponent() => FutureBuilder<List<OrderDetail>>(
      future: orderList,
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
            return orderListComponent(data);
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.sizeOf(context).height * 0.4,
              child: const Center(
                child: Text(
                  AppStringConstants.noMenuItem,
                  style: AppStyles.bodyMessageColorDark14,
                ),
              ),
            );
          }
        }
      });

  Widget orderListComponent(List<OrderDetail> orderList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        var order = orderList[index];
        return OrderCardWidget(
          order: order,
          onItemClick: _showOrderDetails,
        );
      },
    );
  }

  void _showOrderDetails(order) {}
}
