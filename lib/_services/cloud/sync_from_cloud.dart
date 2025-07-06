import '../../_helpers/common/global.dart';
import '../../_helpers/debug/debug.dart';
import '../activity/save_activity.dart';
import '../hive/sync_to_local.dart';
import 'realtime.dart';

Future<bool> syncFromCloud(String space, String timestamp, String activity) async {
  bool success = false;
  try {
    List<String> activityData = splitList(activity, clearEmpties: false);
    String db = activityData[0];
    String action = activityData[1];
    String parent = activityData[2];
    String id = activityData[3];
    String sid = activityData[4];
    String key = activityData[5];

    bool isNew = action == 'c';
    bool isDelete = action == 'd';

    show('::syncFromCloud: $db,$space,$action,$parent,$id,$sid,$key');

    // new or edit
    if (isNew) {
      await cloud
          .getData(db: db, '$space/$parent${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}${key.isNotEmpty ? '/$key' : ''}')
          .then((snapshot) async {
        var value = snapshot.value;

        if (value != null) {
          await syncToLocal(action: action, parent: parent, id: id, sid: sid, key: key, value: value);
        }
      });
    }
    // delete
    if (isDelete) {
      await syncToLocal(action: action, parent: parent, id: id, sid: sid, key: key);
    }

    await saveActivity(space, timestamp, activity);
    success = true;
  } catch (e) {
    logError('syncFromCloud', e);
    success = false;
  }

  return success;
}
