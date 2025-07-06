import 'package:intl/intl.dart';

import '../_helpers/common/global.dart';
import '../_helpers/extentions/date_time.dart';
import '../_helpers/extentions/strings.dart';
import '../_state/_providers.dart';

class DateItem {
  final String date;

  DateItem(this.date) {
    var dateTime_ = DateTime.tryParse(date);
    isBad = dateTime_ == null;
    dateTime = dateTime_ ?? now();
  }

  DateItem.fromTime(String time) : this('${DateTime.now().datePart()} $time');
  DateItem.now() : this(now().datePart());
  DateItem.bad() : this('');

  late DateTime dateTime;
  bool isBad = false;

  int hour() => dateTime.hour;
  int day() => dateTime.day;
  int month() => dateTime.month;
  int year() => dateTime.year;
  int weekNo() => dateTime.weekNo();
  String monthTitle() => DateFormat('MMMM').format(dateTime);
  String monthTitleShort() => DateFormat('MMM').format(dateTime);
  String dayTitleShort() => DateFormat('E').format(dateTime);
  String datePart() => dateTime.datePart();
  String timePart() => dateTime.timePart();
  String timePart12() => dateTime.timePart12();
  String info() {
    if (isToday()) {
      return 'Today, ${timePart12()}';
    } else if (datePart() == now().add(Duration(days: 1)).datePart()) {
      return 'Tommorrow, ${timePart12()}';
    } else {
      return DateFormat('E MMM d, yyy hh:mm a').format(dateTime);
    }
  }

  String dateInfo() => DateFormat('E MMM d, yyy').format(dateTime);
  String weekInfo() => DateFormat('MMM yyy').format(state.dates.weekDates[3].dateTime());
  String monthInfo() => DateFormat('MMM yyy').format(dateTime);

  bool isToday() => date.datePart() == now().datePart();
  bool isCurrentMonth() => month() == now().month && year() == now().year;
  bool isCurrentYear() => year() == now().year;
  bool isWeekend() => [6, 7].contains(dateTime.weekday);
  bool isSelectedMonth() => dateTime.month == state.dates.date.month();
  bool isFuture() => dateTime.isAfter(now().add(const Duration(days: 1)));
  bool isPast() => dateTime.isBefore(now().subtract(const Duration(days: 1)));
  bool isYesterday() => date == now().subtract(const Duration(days: 1)).datePart();
}
