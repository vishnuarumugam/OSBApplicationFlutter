import '../../../app/app.dart';

class AppItemCounterWidget extends StatefulWidget {
  final void Function(dynamic) onItemChange;
  double? width;
  Color? backgroundColor;
  int counterValue;

  AppItemCounterWidget({
    required this.onItemChange,
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
              counter = (counter > 0) ? counter - 1 : 0;
              widget.onItemChange.call(counter);
              setState(() {});
            },
            child: const Icon(
              Icons.remove,
              color: AppColors.colorDark,
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
              counter += 1;
              widget.onItemChange.call(counter);
              setState(() {});
            },
            child: const Icon(
              Icons.add,
              color: AppColors.colorDark,
            ),
          ),
        ],
      ),
    );
  }
}
