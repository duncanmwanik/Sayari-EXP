import '../../_helpers/debug/debug.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_variables/constants.dart';
import '../hive/boxes.dart';
import '../hive/store.dart';

bool isActivityActedOn(String spaceId, String timestamp) {
  try {
    return local(activity, space: spaceId).containsKey(timestamp);
  } catch (e) {
    logError('is-activity-acted-on', e);
    return false;
  }
}

Future<void> deleteActivity(String activityId) async {
  try {
    local(activity).delete(activityId);
    popWhatsOnTop();
  } catch (e) {
    logError('delete-activity-for-user', e);
  }
}

String lastActivity(String subject) => activityVersionBox.get(subject, defaultValue: '');
