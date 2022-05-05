import 'package:intl/intl.dart';

getDateTime(DateTime? dateTime, {bool addTimeFormat = true}) {
  String dateFormat = 'yyyy년 MM월 dd일';
  String timeFormat = 'HH시 mm분';
  if (addTimeFormat) dateFormat = '$dateFormat $timeFormat';
  return DateFormat(dateFormat).format(dateTime!.add(Duration(hours: 18)));
}

Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}
