import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../../spaces/_helpers/common.dart';

Future<void> editFlag(String newFlag, String color, String previousFlag) async {
  try {
    String spaceId = liveSpace();
    local(features.flags).put(newFlag, color);
    local(features.flags).delete(previousFlag);

    await sync.delete(space: spaceId, parent: features.flags, id: previousFlag);
    await sync.create(space: spaceId, parent: features.flags, id: newFlag, value: color);
  } catch (e) {
    logError('edit-flag', e);
  }
}
