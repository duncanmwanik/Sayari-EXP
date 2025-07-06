import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import 'reminders.dart';

List getReminderList(String reminderString) {
  try {
    List reminderList = [];
    splitList(reminderString).forEach((reminder) {
      String reminderNo = reminder.toString().split('.')[0];
      String reminderPeriod = reminder.toString().split('.')[1];

      reminderList.add('$reminderNo ${reminderPeriodsMap[reminderPeriod]}${reminderNo == '1' ? '' : ''}');
    });

    return reminderList;
  } catch (e) {
    return [];
  }
}

String newReminderTime() {
  return '${now().add(Duration(days: 1)).datePart()} 08:00:00';
}
