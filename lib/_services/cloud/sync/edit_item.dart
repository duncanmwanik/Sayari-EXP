import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/edit.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/files/_helpers/upload.dart';
import '../../hive/sync_to_local.dart';
import '../sync_to_cloud.dart';
import 'compare_data.dart';
import 'validation.dart';

Future<void> editItem({bool pop = false}) async {
  String parent = state.input.item.parent;

  try {
    // only continue if itemData has required data
    if (validateItemData()) {
      List<EditedKey> editedKeys = compareData();
      // close dialog/sheet
      if (!state.input.item.type.isSpace()) popWhatsOnTop();

      if (editedKeys.isNotEmpty) {
        String id = state.input.item.id;

        editedKeys.forEach((editedKey) async {
          if (editedKey.toSync) {
            String sid = editedKey.parentKey.isNotEmpty ? editedKey.parentKey : state.input.item.sid;
            await syncToLocal(action: editedKey.action, parent: parent, id: id, sid: sid, key: editedKey.key, value: editedKey.value);
            await syncToCloud(action: editedKey.action, parent: parent, id: id, sid: sid, key: editedKey.key, value: editedKey.value);
          }
        });

        handleFilesUpload(editedKeys: editedKeys);
        // registerReminder(item: state.input.item);
        if (pop) popWhatsOnTop();
      }
    }
  } catch (e) {
    logError('editItem: $parent', e);
  }
}
