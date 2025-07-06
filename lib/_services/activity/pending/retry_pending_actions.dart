import 'dart:async';

import '../../../_helpers/common/internet.dart';
import '../../../_helpers/debug/debug.dart';
import '../../cloud/sync_to_cloud.dart';
import '../../hive/boxes.dart';

//
// We retry each pending sync every 5 minutes in the backgound.
//
Future<void> doPendingSync() async {
  Timer.periodic(const Duration(minutes: 3), (Timer timer) async {
    if (await isOffline()) return;

    pendingBox.toMap().forEach((pendingId, syncAction) async {
      await syncToCloud(
        db: syncAction['db'],
        space: syncAction['space'],
        action: syncAction['action'],
        parent: syncAction['parent'],
        value: syncAction['value'],
        id: syncAction['id'],
        sid: syncAction['sid'],
        key: syncAction['key'],
        log: syncAction['log'],
      ).then((successful) {
        show('::Pending Action [ $pendingId : $syncAction ] successful.');
        if (successful) {
          // we remove the sync if complete
          pendingBox.delete(pendingId);
        } else {
          show('::Pending Action [ $pendingId : $syncAction ] failed!');
        }
      });
    });
  });
}
