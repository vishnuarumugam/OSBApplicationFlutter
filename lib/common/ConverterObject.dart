import 'package:intl/intl.dart';
import 'package:osb/common/constant.dart';

class ConverterObject {
  static String milliToDateConverter(int? milliSecs) {
    if (milliSecs != null) {
      final sdf = DateFormat('dd-MMM-yyyy');
      final date = DateTime.fromMillisecondsSinceEpoch(milliSecs);
      return sdf.format(date);
    }
    return Constants.dashed; // You can customize this string as needed
  }
}