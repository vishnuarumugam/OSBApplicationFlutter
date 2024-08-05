import 'package:intl/intl.dart';
import '../../../app/app.dart';

class ConverterObject {
  static String milliToDateConverter(int? milliSecs) {
    if (milliSecs != null) {
      final sdf = DateFormat('dd-MMM-yyyy');
      final date = DateTime.fromMillisecondsSinceEpoch(milliSecs);
      return sdf.format(date);
    }
    return AppStringConstants.dashed; // You can customize this string as needed
  }
}
