import '../../../_helpers/extentions/strings.dart';

String getDateTime({required String previous, String? date, String? time}) {
  String dateTime = '';

  if (date != null) {
    if (previous.hasTimePart()) {
      dateTime = '$date ${previous.timePart()}';
    } else {
      dateTime = date;
    }
  }
  if (time != null) {
    if (previous.hasDatePart()) {
      dateTime = '${previous.datePart()} $time';
    } else {
      dateTime = time;
    }
  }

  return dateTime;
}
