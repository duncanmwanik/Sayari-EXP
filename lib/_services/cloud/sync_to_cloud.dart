import '../../_helpers/common/global.dart';
import '../../_helpers/common/helpers.dart';
import '../../_helpers/common/internet.dart';
import '../../_helpers/debug/debug.dart';
import '../../_variables/constants.dart';
import '../../features/spaces/_helpers/common.dart';
import '../activity/pending/pending_actions.dart';
import '../hive/boxes.dart';
import 'realtime.dart';

Future<bool> syncToCloud({
  String db = spaces,
  String? space,
  required String action,
  String parent = '',
  String id = '',
  String sid = '',
  String key = '',
  dynamic value,
  bool log = true,
}) async {
  space = space ?? liveSpace();
  bool success = false;

  // no sync for demo
  if (isDemo()) return success;
  // if no internet
  if (await isOffline()) {
    await addToPendingActions(db: db, space: space, action: action, parent: parent, id: id, sid: sid, key: key, value: value, log: log);
    return success;
  }

  try {
    show('::syncToCloud: $db,$action,$parent,$id,$sid,$key ');
    bool isNew = action.startsWith('c');
    bool isDelete = action.startsWith('d');
    String path =
        '$space${parent.isNotEmpty ? '/$parent' : ''}${id.isNotEmpty ? '/$id' : ''}${sid.isNotEmpty ? '/$sid' : ''}${key.isNotEmpty ? '/$key' : ''}';

    // new + editing
    if (isNew) {
      await cloud.writeData(db: db, path, value);
    }
    // deleting
    else if (isDelete) {
      await cloud.deleteData(db: db, path);
    }

    // if action is to delete space, we don't log activity
    if (db == spaces && parent.isEmpty && isDelete) {
      log = false;
    }

    // logging activity
    // This will log the sync operation to update listening users by updating the latest space activity version
    if (log) {
      String timeStamp = getUniqueId();
      String activity = '$db,$action,$parent,$id,$sid,$key';
      // save activity as latest to avoid sync-from-cloud since local data is already updated
      // if its from shared screen, we dont
      if (!isShare()) activityVersionBox.put(space, timeStamp);
      // show('to: $timeStamp');
      await cloud.writeData(db: db, '$space/activity/$timeStamp', activity);
      await cloud.writeData(db: db, '$space/activity/0', timeStamp);
    }

    success = true;
  } catch (e) {
    // we should ensure no errors are expected before reaching here
    // we add the sync action to pending actions for retry.
    await addToPendingActions(db: db, space: space, action: action, parent: parent, id: id, sid: sid, key: key, value: value, log: log);
    logError('syncToCloud-$parent-$action-$id-$sid-$key-$value', e);
  }

  return success;
}
