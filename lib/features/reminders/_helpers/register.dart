import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_models/item.dart';
import '../../../_services/notifications/create_notification.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import 'reminders.dart';

Future<void> registerReminder({
  required Item item,
  String? listName,
}) async {
  try {
    String body = '';
    Map<String, String> data = {};
    String reminder = item.reminder();

    if (reminder.isNotEmpty) {
      //
      // for sessions
      //
      if (item.type == features.calendar) {
        String lead = item.data['l'] != null ? '<br>Led by: <b>${item.data['l']}</b>.' : '';
        String venue = item.data[itemVenue] != null ? '<br>Venue: <b>${item.data[itemVenue]}</b>.' : '';
        String description = item.data['a'] != null ? '<br>${item.data['a']}.' : '';
        List remindersList = splitList(item.data['r']);

        if (remindersList.isNotEmpty) {
          for (String reminder in remindersList) {
            int reminderInMinutes = reminderTimeInMinutes(reminder);
            DateTime date = DateTime.parse(item.start()).subtract(Duration(minutes: reminderInMinutes));

            if (date.isAfter(now())) {
              int nid = notificationId(item.id) + reminderInMinutes;
              body = 'Starts in $reminderInMinutes minutes. $lead $venue $description';
              data = {'item.type': item.type};

              await createReminderNotification(id: nid, title: item.title(), body: body, data: data, date: date);
            }
          }
        }
      }
      //
      // all others
      //
      else {
        DateTime date = DateTime.parse(reminder);

        if (date.isAfter(now())) {
          //
          if (item.type == features.notes) {
            body = item.content();
            data = {'item.type': item.type};
          }
          //
          if (item.type == features.notes) {
            body = 'Check your task items.';
            data = {'item.type': item.type};
          }
          //
          await createReminderNotification(id: notificationId(item.id), title: item.title(), body: body, data: data, date: date);
          //
        }
        //
      }
      //
    }
    //
  } catch (e) {
    logError('register-$item.type-notification', e);
  }
}
