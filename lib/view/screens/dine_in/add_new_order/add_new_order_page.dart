import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../app/app.dart';

class AddNewOrderPage extends StatefulWidget {
  const AddNewOrderPage({super.key});

  @override
  State<AddNewOrderPage> createState() => _AddNewOrderPageState();
}

class _AddNewOrderPageState extends State<AddNewOrderPage> {
  late TextEditingController tableNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: AppStringConstants.newOrder,
          onLeadingTap: () {},
          onActionTap: () {},
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
      height: MediaQuery.sizeOf(context).height,
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            tableDetailComponent(),
            fieldSpacer(15),
            fieldSpacer(8),
          ],
        ),
      ),
    );
  }

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
            GestureDetector(
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width,
                    constraints: const BoxConstraints(minHeight: 48),
                    decoration: const BoxDecoration(
                        color: AppColors.colorDark,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: const Text(
                      AppStringConstants.placeOrder,
                      style: AppStyles.buttonTvStyle,
                    ))),
          ]),
    );
  }

  Widget tableDetailComponent() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
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
          waiterNameComponent(),
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
          child: Text(
              '${AppStringConstants.tableName}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: tableNumber,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.selectTableName,
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

  Column occupancyComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.occupancy}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: tableNumber,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.selectTableName,
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

  Column waiterNameComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
              '${AppStringConstants.waiterName}${AppStringConstants.asterick}',
              style: AppStyles.inputHeaderBlack12),
        ),
        SizedBox(
          child: TextField(
            controller: tableNumber,
            style: AppStyles.inputTvStyle,
            decoration: const InputDecoration(
              hintText: AppStringConstants.selectWaiterName,
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
}
