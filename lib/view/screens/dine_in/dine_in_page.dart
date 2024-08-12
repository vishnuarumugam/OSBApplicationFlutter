import '../../../app/app.dart';

class DineInPage extends StatefulWidget {
  const DineInPage({super.key});

  @override
  State<DineInPage> createState() => _DineInPageState();
}

class _DineInPageState extends State<DineInPage> {
  Set<DineInEnum> segmentSelection = <DineInEnum>{DineInEnum.activeOrders};

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
            )
          ],
        ),
      ),
    );
  }
}
