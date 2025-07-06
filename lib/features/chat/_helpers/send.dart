import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/sync_to_local.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/editor/helpers/helpers.dart';
import '../../../_widgets/files/_helpers/upload.dart';
import '../../user/_helpers/helpers.dart';

Future<void> sendMessage() async {
  try {
    bool hasMessage = !state.editor.editorState.document.isEmpty;
    bool hasAttachment = state.input.item.hasFiles();

    if (hasMessage || hasAttachment) {
      hideKeyboard();
      String message = state.editor.getJson();
      Map messageData = {...state.input.item.data};
      Map files = {...state.input.item.files()};
      state.editor.reset();
      state.editor.clear(chatBlocks);
      state.input.clear();
      rebuildEditor();

      String messageId = getUniqueId();
      messageData.addAll({itemContent: message, itemEmail: liveUserEmail()});
      String date = now().datePart();
      syncToLocal(action: 'c', parent: features.chat, id: date, sid: messageId, value: messageData);
      sync.create(parent: features.chat, id: date, sid: messageId, value: messageData);
      handleFilesUpload(files: files);
    }
  } catch (e) {
    logError('sendMessage', e);
  }
}
