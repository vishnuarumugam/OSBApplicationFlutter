import 'dart:developer';

import 'package:om_saravana_bhavan_application/view/screens/screens.dart';

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
    // showLoader(context);
    try {
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
      setState(() {});
    } catch (error) {
      log("Error: $error");
    }
  }

  Future<void> deleteOrder(OrderDetail order) async {
    showLoader(context);
    try {
      var response =
          await Provider.of<DineInPageViewModel>(context, listen: false)
              .deleteOrder(order);
      if (response.statusCode == 200) {
        getOrder();
      }
      showToast(context, response.message);
      hideLoader();
      setState(() {});
    } catch (error) {
      hideLoader();
      log("Error: $error");
    }
  }

  Future<void> updateOrder(OrderDetail order) async {
    showLoader(context);
    try {
      var response =
          await Provider.of<DineInPageViewModel>(context, listen: false)
              .updateOrder(order);
      if (response.statusCode == 200) {
        getOrder();
      }
      showToast(context, response.message);
      hideLoader();
      setState(() {});
    } catch (error) {
      hideLoader();
      log("Error: $error");
    }
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
          pushToScreen(context, AddNewOrderPage());
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
            const SizedBox(height: 20),
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
          var data = snapshot.data;
          if (segmentSelection.first == DineInEnum.activeOrders) {
            data = snapshot.data
                ?.where((order) => order.orderStatus?.toLowerCase() == "active")
                .toList();
          } else if (segmentSelection.first == DineInEnum.openBills) {
            data = snapshot.data
                ?.where((order) => order.orderStatus?.toLowerCase() == "open")
                .toList();
          } else {
            data = snapshot.data
                ?.where((order) => order.orderStatus?.toLowerCase() == "closed")
                .toList();
          }
          if (data != null && data.isNotEmpty) {
            if (segmentSelection.first == DineInEnum.activeOrders) {
              return activeOrderListComponent(data, true);
            } else if (segmentSelection.first == DineInEnum.openBills) {
              return openOrderListComponent(data, true);
            } else {
              return closedOrderListComponent(data);
            }
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

  Widget activeOrderListComponent(
      List<OrderDetail> orderList, bool showSlideOption) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        var order = orderList[index];
        return (!showSlideOption)
            ? OrderCardWidget(
                order: order,
                onItemClick: _updateOrderDetails,
              )
            : Dismissible(
                key: Key(order.documentId ?? ""),
                background: Container(
                  color: AppColors.colorLight,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.arrow_circle_up_rounded,
                          color: AppColors.colorDark),
                      SizedBox(
                        width: 8,
                      ),
                      Text(AppStringConstants.createBill,
                          style: TextStyle(color: AppColors.colorDark)),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: AppColors.negativeColor,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      Text(AppStringConstants.delete,
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    // Show a confirmation dialog for delete action
                    final bool confirmDelete = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            AppStringConstants.confirmDelete,
                            style: AppStyles.headingBlack16,
                          ),
                          content: const Text(
                            AppStringConstants.confirmDeleteMsg,
                            style: AppStyles.bodyMediumBlack14,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                AppStringConstants.cancel,
                                style: AppStyles.buttonTvStyleColorDark,
                              ),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: const Text(
                                AppStringConstants.billDelete,
                                style: AppStyles.buttonTvStyleColorDark,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (confirmDelete) {
                      await deleteOrder(order);
                    }
                  } else {
                    final bool confirmCreate = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            AppStringConstants.confirmCreate,
                            style: AppStyles.headingBlack16,
                          ),
                          content: const Text(
                            AppStringConstants.confirmCreateMsg,
                            style: AppStyles.bodyMediumBlack14,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                AppStringConstants.cancel,
                                style: AppStyles.buttonTvStyleColorDark,
                              ),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: const Text(
                                AppStringConstants.create,
                                style: AppStyles.buttonTvStyleColorDark,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (confirmCreate) {
                      order.orderStatus = "open";
                      await updateOrder(order);
                    }
                  }
                  return false;
                },
                child: OrderCardWidget(
                  order: order,
                  onItemClick: _updateOrderDetails,
                ),
              );
      },
    );
  }

  Widget openOrderListComponent(
      List<OrderDetail> orderList, bool showSlideOption) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        var order = orderList[index];
        return (!showSlideOption)
            ? OrderCardWidget(
                order: order,
                onItemClick: _showOrderDetails,
              )
            : Dismissible(
                key: Key(order.documentId ?? ""),
                background: Container(
                  color: AppColors.colorLight,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.cancel_outlined, color: AppColors.colorDark),
                      SizedBox(
                        width: 8,
                      ),
                      Text(AppStringConstants.closeBill,
                          style: TextStyle(color: AppColors.colorDark)),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: AppColors.colorLight,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.cancel_outlined, color: AppColors.colorDark),
                      SizedBox(
                        width: 8,
                      ),
                      Text(AppStringConstants.closeBill,
                          style: TextStyle(color: AppColors.colorDark)),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                confirmDismiss: (direction) async {
                  final bool confirmCreate = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          AppStringConstants.confirmClose,
                          style: AppStyles.headingBlack16,
                        ),
                        content: const Text(
                          AppStringConstants.confirmCloseMsg,
                          style: AppStyles.bodyMediumBlack14,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              AppStringConstants.cancel,
                              style: AppStyles.buttonTvStyleColorDark,
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            child: const Text(
                              AppStringConstants.close,
                              style: AppStyles.buttonTvStyleColorDark,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  if (confirmCreate) {
                    order.orderStatus = "closed";
                    await updateOrder(order);
                  }
                  return false;
                },
                child: OrderCardWidget(
                  order: order,
                  onItemClick: _showOrderDetails,
                ),
              );
      },
    );
  }

  Widget closedOrderListComponent(List<OrderDetail> orderList) {
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

  void _updateOrderDetails(OrderDetail order) {
    pushToScreen(
        context,
        AddNewOrderPage(
          existingOrder: true,
          orderDetail: order,
        ));
  }

  void _showOrderDetails(OrderDetail order) {
    pushToScreen(
        context,
        NewOrderConfirmationPage(
          existingOrder: true,
          orderDetails: order,
          onOrderListChanged: () {},
        ));
  }
}
