import '../../../_helpers/debug/debug.dart';
import '../../hive/sync_to_local.dart';
import '../sync_to_cloud.dart';

Future<void> quickEdit({
  String? space,
  String action = 'c',
  String parent = '',
  String id = '',
  String sid = '',
  String key = '',
  dynamic value,
}) async {
  try {
    await syncToLocal(parent: parent, action: action, id: id, sid: sid, key: key, value: value);
    await syncToCloud(space: space, parent: parent, action: action, id: id, sid: sid, key: key, value: value);
  } catch (e) {
    logError('quickEdit-$action,$parent,$id,$sid,$key,$value', e);
  }
}
