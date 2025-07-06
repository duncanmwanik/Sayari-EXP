import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/sync_to_local.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/features.dart';

Future<void> addNewTag(String tagName, [String? editTagId]) async {
  try {
    String tagId = editTagId ?? getUniqueId();
    String tagData = '${state.temp.temp.length < 3 ? state.temp.temp : 'x'},$tagName';

    await syncToLocal(action: 'c', parent: features.tags, id: tagId, value: tagData);
    await sync.create(parent: features.tags, id: tagId, value: tagData);
  } catch (e) {
    logError('addNewTag', e);
  }
}
