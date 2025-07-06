import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_models/date.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';

Future<void> goToToday() async {
  state.dates.updateDate(now().datePart());
  if (state.dates.isWeek()) state.dates.updateWeekDates(now());
}

Map getHourMap(Map source, int hour) {
  source.removeWhere((key, value) => DateItem(value['s']).hour() != hour);
  return source;
}

void removeDuplicateSessionReminders() {
  if (state.input.item.hasReminder()) {
    state.input.update(
      itemReminder,
      joinList(splitList(state.input.item.reminder()).toSet().toList()),
    );
  }
}

String getNewSessionTime({DateItem? date, int? hour, int offset = 0}) {
  DateTime refDateTime = DateTime(
    date != null ? date.year() : now().year,
    date != null ? date.month() : now().month,
    date != null ? date.day() : now().day,
    hour ?? now().hour,
  );

  return refDateTime.add(Duration(hours: offset)).format();
}
