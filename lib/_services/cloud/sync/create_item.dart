import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_widgets/files/_helpers/upload.dart';
import '../../../_widgets/others/toast.dart';
import '../../hive/sync_to_local.dart';
import '../sync.dart';
import 'validation.dart';

Future<void> createItem({bool pop = false}) async {
  String parent = state.input.item.parent;

  try {
    hideKeyboard();

    if (validateItemData(true)) {
      await syncToLocal(action: 'c', parent: parent, id: state.input.item.id, sid: state.input.item.sid, value: state.input.item.data);
      await sync.create(parent: parent, id: state.input.item.id, sid: state.input.item.sid, value: state.input.item.data);
      await handleFilesUpload(files: state.input.item.allFiles());
      // registerReminder(item: state.input.item);
      if (pop) popWhatsOnTop();
    }
  } catch (e) {
    toastError('Could not create item.');
    logError('createItem-$parent', e);
  }
}
