import 'package:intl/intl.dart';

getDateTime(DateTime? dateTime, {bool addTimeFormat = true}) {
  String dateFormat = 'yyyy년 MM월 dd일';
  String timeFormat = 'HH시 mm분';
  if (addTimeFormat) dateFormat = '$dateFormat $timeFormat';
  return DateFormat(dateFormat).format(dateTime!);
}
