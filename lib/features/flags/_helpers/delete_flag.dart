import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../../spaces/_helpers/common.dart';

Future<void> deleteFlag(String flag) async {
  try {
    String spaceId = liveSpace();
    local(features.flags).delete(flag);
    await sync.delete(space: spaceId, parent: features.flags, id: flag);
  } catch (e) {
    logError('delete-flag', e);
  }
}
