import '../../../../app/app.dart';

class OrderCardWidget extends StatefulWidget {
  final OrderDetail order;
  final void Function(dynamic)? onItemClick;

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
      decoration: BoxDecoration(
          color: AppColors.colorLight,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorGreyOut.withOpacity(0.1),
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
                      widget.order.tableName ?? AppStringConstants.dashed,
                      style: AppStyles.bodyHeaderBlack14,
                      textAlign: TextAlign.left,
                    ),
                    fieldSpacer(8),
                    Text(
                      (widget.order.occupancyCount ?? AppStringConstants.dashed)
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

  Padding priceTag() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              (widget.order.totalOrderAmount != null)
                  ? "${AppStringConstants.rupeeSymbol} ${widget.order.totalOrderAmount.toString()}"
                  : AppStringConstants.dashed,
              style: AppStyles.bodyHeaderBlack14,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
