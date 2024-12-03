import '../../../../app/app.dart';

class OrderCardWidget extends StatefulWidget {
  final OrderDetail order;
  final void Function(OrderDetail)? onItemClick;

  OrderCardWidget({
    super.key,
    required this.order,
    this.onItemClick,
  });

  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.5,
            color: AppColors.colorLightest,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorGreyOut.withOpacity(0.05),
              blurRadius: 1,
              spreadRadius: 1.0,
              offset: const Offset(0, 4),
            )
          ]),
      child: InkWell(
        onTap: () {
          if (widget.onItemClick != null) {
            widget.onItemClick?.call(widget.order);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Table: ${widget.order.tableName ?? AppStringConstants.dashed}",
                      style: AppStyles.bodyHeaderBlack14,
                      textAlign: TextAlign.left,
                    ),
                    fieldSpacer(8),
                    Text(
                      "Occupancy: ${widget.order.occupancyCount ?? AppStringConstants.dashed}"
                          .toString(),
                      style: AppStyles.bodyRegularBlack12,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${AppStringConstants.rupeeSymbol} ${widget.order.totalOrderAmount ?? AppStringConstants.dashed}",
                      style: getOrderTxtColor(widget.order.orderStatus),
                      textAlign: TextAlign.left,
                    ),
                    fieldSpacer(8),
                    Text(
                      "Items: ${widget.order.itemList?.length ?? AppStringConstants.dashed}"
                          .toString(),
                      style: AppStyles.bodyRegularBlack12,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle getOrderTxtColor(String? orderStatus) {
    if (orderStatus == null) {
      return AppStyles.activeOrder;
    }
    switch (orderStatus.toLowerCase()) {
      case "active":
        return AppStyles.activeOrder;
      case "open":
        return AppStyles.openOrder;
      case "closed":
        return AppStyles.closedOrder;
      default:
        return AppStyles.activeOrder;
    }
  }
}
