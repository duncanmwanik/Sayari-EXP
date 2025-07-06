import 'dart:async';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../hive/boxes.dart';

Future<void> addToPendingActions({
  required String db,
  required String space,
  required String action,
  required String parent,
  String id = '',
  String sid = '',
  String key = '',
  dynamic value,
  bool log = true,
}) async {
  String pendingActionId = getUniqueId();

  await pendingBox.put(pendingActionId, {
    'db': db,
    'space': space,
    'action': action,
    'parent': parent,
    'id': id,
    'sid': sid,
    'key': key,
    'value': value,
    'log': log,
  });
  show('New pending action: $pendingActionId > $parent $action $key : $id');
}

// remove this
bool isPendingItem(String id) {
  try {
    return pendingBox.containsKey(id);
  } catch (e) {
    return false;
  }
}

void removeFromPendingActions(String id) {
  pendingBox.delete(id);
  show('Removed pending action: $id');
}
