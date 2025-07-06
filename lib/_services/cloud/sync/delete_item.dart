import '../../../_helpers/debug/debug.dart';
import '../../../_models/item.dart';
import '../../../_widgets/files/_helpers/delete.dart';
import '../../hive/sync_to_local.dart';
import '../sync.dart';

Future<void> deleteItemForever(Item item) async {
  try {
    show('delete ${item.parent} ${item.id} ${item.sid}');
    syncToLocal(action: 'd', parent: item.parent, id: item.id, sid: item.sid);
    sync.delete(parent: item.parent, id: item.id, sid: item.sid);
    handleFilesDeletion(item.allFiles());
  } catch (e) {
    logError('deleteItemForever', e);
  }
}
