import 'dart:developer';

import '../../../../app/app.dart';

class NewOrderConfirmationPage extends StatefulWidget {
  bool existingOrder;
  final OrderDetail orderDetails;
  final VoidCallback onOrderListChanged;

  NewOrderConfirmationPage({
    super.key,
    this.existingOrder = false,
    required this.orderDetails,
    required this.onOrderListChanged,
  });

  @override
  State<NewOrderConfirmationPage> createState() =>
      _NewOrderConfirmationPageState();
}

class _NewOrderConfirmationPageState extends State<NewOrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
          title: AppStringConstants.reviewOrder,
          showLeading: true,
          showAction: false),
      bottomNavigationBar: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screenView(),
    );
  }

  createOrder() async {
    showLoader(context);
    try {
      var response =
          await Provider.of<DineInPageViewModel>(context, listen: false)
              .createOrder(widget.orderDetails);
      if (response.statusCode == 200) {
        widget.onOrderListChanged();
      }
      showToast(context, response.message);
      hideLoader();
    } catch (error) {
      hideLoader();
      rethrow;
    }
  }

  Widget screenView() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                tableDetailComponent(),
                fieldSpacer(30),
                orderItemListComponent(widget.orderDetails.itemList)
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListView orderItemListComponent(List<OrderItemDetailModel>? orderData) =>
      ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: orderData!.length,
          separatorBuilder: (context, index) => const SizedBox(
                height: 1,
                child: Divider(
                  color: AppColors.colorDark,
                  thickness: 0.8,
                ),
              ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              color: AppColors.colorLight.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 4, top: 4, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    orderData[index].itemName ??
                                        AppStringConstants.dashed,
                                    style: AppStyles.bodyHeaderBlack14,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(2.0),
                                //   child: Text(
                                //     (orderData[index].itemPrice ??
                                //             AppStringConstants.dashed)
                                //         .toString(),
                                //     style: AppStyles.bodyRegularBlack12,
                                //     overflow: TextOverflow.ellipsis,
                                //     maxLines: 1,
                                //     softWrap: false,
                                //   ),
                                // )
                              ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 16, top: 4, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'x ${(orderData[index].itemCount ?? AppStringConstants.dashed).toString()}',
                                    style: AppStyles.bodyHeaderBlack14,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    '${AppStringConstants.rupeeSymbol} ${(orderData[index].itemPrice ?? AppStringConstants.dashed).toString()}',
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
            );
          });

  Widget floatingActionButton() {
    return SizedBox(
      height: (!widget.existingOrder) ? 140 : 80,
      child: Column(
        children: [
          Container(
            height: (!widget.existingOrder) ? 40 : 80,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
            color: AppColors.colorLight.withOpacity(0.5),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringConstants.orderPrice,
                      style: AppStyles.bodySemiBoldBlack14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${AppStringConstants.rupeeSymbol} ${(getTotalOrderAmount() ?? AppStringConstants.dashed).toString()}',
                      style: AppStyles.bodySemiBoldBlack14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (!widget.existingOrder)
            Container(
              alignment: Alignment.center,
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: AppColors.colorGridLine,
                  width: 2.0,
                )),
                color: AppColors.colorWhite,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          widget.orderDetails.totalOrderAmount =
                              getTotalOrderAmount();
                          widget.orderDetails.createdAt =
                              DateTime.now().millisecondsSinceEpoch;
                          widget.orderDetails.updatedAt =
                              DateTime.now().millisecondsSinceEpoch;
                          widget.orderDetails.orderStatus = "active";
                          log("orderDetails ${widget.orderDetails}");
                          setState(() {});
                          createOrder();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.sizeOf(context).width,
                            constraints: const BoxConstraints(minHeight: 48),
                            decoration: const BoxDecoration(
                                color: AppColors.colorDark,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: const Text(
                              AppStringConstants.confirmOrder,
                              style: AppStyles.buttonTvStyle,
                            ))),
                  ]),
            ),
        ],
      ),
    );
  }

  Widget tableDetailComponent() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: AppColors.colorLight),
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 5, child: tableNumberComponent()),
              Expanded(flex: 1, child: fieldSpacer(8)),
              Expanded(flex: 3, child: occupancyComponent()),
            ],
          ),
          fieldSpacer(8),
          Row(
            children: [
              Expanded(flex: 5, child: waiterNameComponent()),
              Expanded(flex: 1, child: fieldSpacer(8)),
              Expanded(flex: 3, child: orderItemCountComponent()),
            ],
          ),
        ],
      ),
    );
  }

  Column tableNumberComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(AppStringConstants.tableName,
              style: AppStyles.inputHeaderBlack12),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              widget.orderDetails.tableName ?? AppStringConstants.dashed,
              style: AppStyles.bodySemiBoldColorDark14),
        ),
      ],
    );
  }

  Column occupancyComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(AppStringConstants.occupancy,
              style: AppStyles.inputHeaderBlack12),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              (widget.orderDetails.occupancyCount ?? AppStringConstants.dashed)
                  .toString(),
              textAlign: TextAlign.center,
              style: AppStyles.bodySemiBoldColorDark14),
        ),
      ],
    );
  }

  Column waiterNameComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(AppStringConstants.waiterName,
              style: AppStyles.inputHeaderBlack12),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              widget.orderDetails.waiterName ?? AppStringConstants.dashed,
              style: AppStyles.bodySemiBoldColorDark14),
        ),
      ],
    );
  }

  Column orderItemCountComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(AppStringConstants.totalItems,
              style: AppStyles.inputHeaderBlack12),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              (widget.orderDetails.itemList?.length ??
                      AppStringConstants.dashed)
                  .toString(),
              textAlign: TextAlign.center,
              style: AppStyles.bodySemiBoldColorDark14),
        ),
      ],
    );
  }

  int? getTotalOrderAmount() {
    List<OrderItemDetailModel> orderList = widget.orderDetails.itemList ?? [];
    int totalOrderAmount = 0;
    if (orderList.isNotEmpty) {
      totalOrderAmount = calculateTotalPrice(orderList);
    }
    return totalOrderAmount;
  }

  int calculateTotalPrice(List<OrderItemDetailModel> items) {
    return items
        .where((item) => item.totalItemPrice != null)
        .fold(0, (sum, item) => sum + item.totalItemPrice!);
  }
}
