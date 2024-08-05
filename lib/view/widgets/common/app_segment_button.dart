import '../../../app/app.dart';

enum ButtonSize { large, medium, small }

class AppSegmentedButton<T> extends StatelessWidget {
  final ButtonSize buttonSize;
  final Set<T>? selected;
  final ValueChanged<Set<T>>? onSelectionChanged;
  final bool showSelectedIcon;
  final List<ButtonSegment<T>> segments;
  final double? width;
  final Color selectedBackgroundColor;
  final Color unSelectedBackgroundColor;
  final Color selectedTextColor;
  final Color unSelectedTextColor;

  /// [AppSegmentedButton Widget]
  /// This is a widget which is used same as a toggle able button.
  /// It has callback function to change the selection.
  /// We need to pass the type of Segmented button like in example.
  /// It has field to customize the background color of selected and unselected.
  ///
  /// #Example
  /// ```dart
  /// enum Section { section1, section2, section3 }
  /// AppSegmentedButton<Section>(
  ///           selected: selectedValue,
  ///           onSelectionChanged: (newSelection) {
  ///             setState(() {
  ///               selectedValue = newSelection;
  ///             });
  ///           },
  ///           showSelectedIcon: false,
  ///           segments: const <ButtonSegment<Section>>[
  ///             ButtonSegment<Section>(
  ///                 value: Section.section1, label: Text("Section 1")),
  ///             ButtonSegment<Section>(
  ///                 value: Section.section2, label: Text("Section 2")),
  ///             ButtonSegment<Section>(
  ///                 value: Section.section3, label: Text("Section 3")),
  ///           ],
  ///         )
  /// ```

  const AppSegmentedButton(
      {Key? key,
      this.buttonSize = ButtonSize.medium,
      this.selected,
      this.onSelectionChanged,
      this.showSelectedIcon = false,
      required this.segments,
      this.width,
      this.selectedBackgroundColor = const Color(0xffF9EBF9),
      this.unSelectedBackgroundColor = const Color(0xffFFFFFF),
      this.selectedTextColor = const Color(0xff4A154B),
      this.unSelectedTextColor = const Color(0xff666666)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<T> selectedValue = selected ?? <T>{};
    return SizedBox(
      width: width ?? getWidth(buttonSize),
      height: 40.0,
      child: SegmentedButton<T>(
        emptySelectionAllowed: false,
        selected: selectedValue,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
            return TextStyle(
              fontWeight: states.contains(MaterialState.selected)
                  ? FontWeight.w500
                  : FontWeight.w400,
              fontSize: 12.0,
              color: states.contains(MaterialState.selected)
                  ? selectedTextColor
                  : unSelectedTextColor,
            );
          }),
          side: MaterialStateProperty.resolveWith(
              (states) => const BorderSide(color: Color(0xffE0E0E0))),
          foregroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? selectedTextColor
                : unSelectedTextColor;
          }),
          backgroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? selectedBackgroundColor
                : unSelectedBackgroundColor;
          }),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onSelectionChanged: (Set<T> newSelection) {
          onSelectionChanged?.call(newSelection);
        },
        showSelectedIcon: showSelectedIcon,
        segments: segments,
      ),
    );
  }

  double getWidth(ButtonSize buttonSize) {
    switch (buttonSize) {
      case ButtonSize.large:
        return 382.0;
      case ButtonSize.medium:
        return 327.0;
      case ButtonSize.small:
        return 272.0;
      default:
        return 327.0;
    }
  }
}
