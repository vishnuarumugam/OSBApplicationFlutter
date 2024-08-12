import '../../../../app/app.dart';

class NewOrderConfirmationPage extends StatefulWidget {
  final OrderDetail orderDetails;

  const NewOrderConfirmationPage({super.key, required this.orderDetails});

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
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screenView(),
    );
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
    return Container(
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
                onTap: () async {},
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width,
                    constraints: const BoxConstraints(minHeight: 48),
                    decoration: const BoxDecoration(
                        color: AppColors.colorDark,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: const Text(
                      AppStringConstants.confirmOrder,
                      style: AppStyles.buttonTvStyle,
                    ))),
          ]),
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
}
