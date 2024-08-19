import 'dart:developer';

import '../../../app/app.dart';

class MenuItemCardWidget extends StatefulWidget {
  final Menu menuItem;
  final bool isItemOrdered;
  final ItemCardType cardType;
  final void Function(dynamic)? onItemClick;
  final void Function(dynamic)? onItemAdded;
  final void Function(dynamic)? onItemRemoved;

  MenuItemCardWidget(
      {super.key,
      required this.menuItem,
      this.isItemOrdered = false,
      this.onItemClick,
      required this.cardType,
      this.onItemAdded,
      this.onItemRemoved});

  @override
  State<MenuItemCardWidget> createState() => _MenuItemCardWidgetState();
}

class _MenuItemCardWidgetState extends State<MenuItemCardWidget> {
  OrderItemDetailModel orderItem = OrderItemDetailModel.withDefaults();

  @override
  void initState() {
    super.initState();
    setValues();
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
            widget.onItemClick?.call(widget.menuItem);
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
                      widget.menuItem.itemName ?? AppStringConstants.dashed,
                      style: AppStyles.bodyHeaderBlack14,
                      textAlign: TextAlign.left,
                    ),
                    fieldSpacer(8),
                    Text(
                      widget.menuItem.itemType ?? AppStringConstants.dashed,
                      style: AppStyles.bodyRegularBlack12,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              ((orderItem.itemCount ?? 0) > 0) ? itemCounter() : priceTag(),
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
              (widget.menuItem.itemPrice != null)
                  ? "${AppStringConstants.rupeeSymbol} ${widget.menuItem.itemPrice.toString()}"
                  : AppStringConstants.dashed,
              style: AppStyles.bodyHeaderBlack14,
              textAlign: TextAlign.right,
            ),
          ),
          fieldSpacer(widget.cardType == ItemCardType.orderList ? 8 : 0),
          widget.cardType == ItemCardType.orderList
              ? InkWell(
                  onTap: () {
                    addOrderItem();
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 1,
                        color: AppColors.colorDark,
                      ),
                    ),
                    child: Text(
                      AppStringConstants.addItem.toUpperCase(),
                      style: AppStyles.bodySemiBoldColorDark14,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget itemCounter() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppItemCounterWidget(
          counterValue: widget.menuItem.itemQty ?? 0,
          width: MediaQuery.sizeOf(context).width * 0.25,
          backgroundColor: AppColors.colorWhite,
          onItemChange: itemCountChange,
        ));
  }

  void itemCountChange(itemCount) {
    if (itemCount > 0) {
      orderItem.itemCount = itemCount;
      orderItem.totalItemPrice =
          ((orderItem.itemCount ?? 0) * (widget.menuItem.itemPrice ?? 0));
      if (widget.onItemAdded != null) {
        widget.onItemAdded?.call(orderItem);
      }
    } else {
      if (widget.onItemRemoved != null) {
        widget.onItemRemoved?.call(orderItem);
      }
      orderItem = OrderItemDetailModel.withDefaults();
    }
    setState(() {});
  }

  void addOrderItem() {
    orderItem.itemCount = 1;
    orderItem.menuId = widget.menuItem.documentId;
    orderItem.itemName = widget.menuItem.itemName;
    orderItem.itemPrice = widget.menuItem.itemPrice;
    orderItem.totalItemPrice =
        ((orderItem.itemCount ?? 0) * (widget.menuItem.itemPrice ?? 0));

    if (widget.onItemAdded != null) {
      widget.onItemAdded?.call(orderItem);
    }
  }

  Future<void> setValues() async {
    if (widget.isItemOrdered) {
      orderItem.itemCount = widget.menuItem.itemQty;
      orderItem.menuId = widget.menuItem.documentId;
      orderItem.itemName = widget.menuItem.itemName;
      orderItem.itemPrice = widget.menuItem.itemPrice;
      orderItem.totalItemPrice =
          ((orderItem.itemCount ?? 0) * (widget.menuItem.itemPrice ?? 0));
    }
  }
}
