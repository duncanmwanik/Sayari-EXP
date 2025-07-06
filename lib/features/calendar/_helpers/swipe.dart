import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';

Future<void> swipeToNew({bool isNext = true, String direction = noValue, int? view}) async {
  if (direction != noValue) isNext = direction == 'right';

  DateTime previous = state.dates.date.dateTime;
  DateTime newDate = now();

  switch (view ?? state.dates.calendarView) {
    // daily
    case dailyView:
      newDate = isNext ? previous.add(Duration(days: 1)) : previous.subtract(Duration(days: 1));
      break;
    // weekly
    case weeklyView:
      newDate = isNext ? previous.add(Duration(days: 7)) : previous.subtract(Duration(days: 7));
      state.dates.updateWeekDates(newDate);
      break;
    // monthly
    case monthlyView:
      newDate = DateTime(
        isNext
            ? previous.month == 12
                ? previous.year + 1
                : previous.year
            : previous.month == 1
                ? previous.year - 1
                : previous.year,
        isNext
            ? previous.month == 12
                ? 1
                : previous.month + 1
            : previous.month == 1
                ? 12
                : previous.month - 1,
      );
      break;
    // yearly
    case yearlyView:
      newDate = DateTime(isNext ? previous.year + 1 : previous.year - 1);
      break;
  }

  state.dates.updateDate(newDate.datePart());
}
