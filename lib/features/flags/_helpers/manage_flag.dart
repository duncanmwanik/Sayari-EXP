import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../../spaces/_helpers/common.dart';

Future<void> createFlag(String flagData) async {
  try {
    String spaceId = liveSpace();
    String flagId = getUniqueId();
    local(features.flags).put(flagId, flagData);
    await sync.create(space: spaceId, parent: features.flags, id: flagId, value: flagData);
  } catch (e) {
    logError('add-flag', e);
  }
}

Future<void> editFlag(String flagId, String flagData) async {
  try {
    String spaceId = liveSpace();
    local(features.flags).put(flagId, flagData);
    await sync.create(space: spaceId, parent: features.flags, id: flagId, value: flagData);
  } catch (e) {
    logError('edit-flag', e);
  }
}

Future<void> deleteFlag(String flagId) async {
  try {
    String spaceId = liveSpace();
    local(features.flags).delete(flagId);
    await sync.delete(space: spaceId, parent: features.flags, id: flagId);
  } catch (e) {
    logError('delete-flag', e);
  }
}
