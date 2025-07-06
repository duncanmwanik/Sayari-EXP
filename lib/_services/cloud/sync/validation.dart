import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';

bool validateItemData([bool isNew = false]) {
  Item item = state.input.item;
  String message = '';
  String title = item.title('');
  bool hasTitle = title.isNotEmpty;

  if (item.type.isSpace()) {
    if (!hasTitle) {
      message = 'Enter space name';
    }
  }

  if (item.type.isCalendar()) {}

  if (item.type.isNote()) {
    if (isNew && !hasTitle && state.editor.editorState.document.isEmpty) {
      return false;
    }
  }

  if (item.type.isKanban()) {
    if (isNew && !hasTitle && item.taskCount() == 0) {
      return false;
    }
  }

  if (item.type.isFinance()) {
    if (isNew && !hasTitle && item.data.isEmpty) {
      return false;
    }
  }

  // show toast message
  if (message.isNotEmpty) {
    toastError(message);
    return false;
  }

  return true;
}
