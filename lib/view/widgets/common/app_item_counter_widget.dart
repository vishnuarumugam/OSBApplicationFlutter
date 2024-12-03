import '../../../app/app.dart';

class AppItemCounterWidget extends StatefulWidget {
  final void Function(dynamic) onItemChange;
  bool disableButton;
  double? width;
  Color? backgroundColor;
  int counterValue;

  AppItemCounterWidget({
    required this.onItemChange,
    this.disableButton = false,
    this.width,
    this.backgroundColor,
    this.counterValue = 0,
    super.key,
  });

  @override
  State<AppItemCounterWidget> createState() => _AppItemCounterWidgetState();
}

class _AppItemCounterWidgetState extends State<AppItemCounterWidget> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = widget.counterValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: widget.width,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.colorGridLine),
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (!widget.disableButton) {
                counter = (counter > 0) ? counter - 1 : 0;
                widget.onItemChange.call(counter);
                setState(() {});
              }
            },
            child: Icon(
              Icons.remove,
              color: (!widget.disableButton)
                  ? AppColors.colorDark
                  : AppColors.colorProgressGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              counter.toString(),
              style: AppStyles.bodyMediumBlack14,
            ),
          ),
          InkWell(
            onTap: () {
              if (!widget.disableButton) {
                counter += 1;
                widget.onItemChange.call(counter);
                setState(() {});
              }
            },
            child: Icon(
              Icons.add,
              color: (!widget.disableButton)
                  ? AppColors.colorDark
                  : AppColors.colorProgressGrey,
            ),
          ),
        ],
      ),
    );
  }
}
