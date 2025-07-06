import '../../../_models/item.dart';
import '../../../_services/cloud/sync/create_item.dart';
import '../../../_services/cloud/sync/edit_item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import 'prepare.dart';

void onTapNote(Item item) {
  if (state.selection.selected.isEmpty) {
    if (item.isTrashed()) {
      toastInfo('Restore item to open it.');
    } else {
      editNote(item);
    }
  } else {
    if (state.selection.isSelected(item.id)) {
      state.selection.unSelect(item.id);
    } else {
      state.selection.select(item);
    }
  }
}

void onLongPressNote(Item item) {
  if (state.selection.isSelected(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item);
  }
}

void whenCompleteNote() {
  if (state.input.item.showEditor()) state.input.update(itemContent, state.editor.getJson());
  // show(state.editor.getJson());
  state.input.item.isNew ? createItem() : editItem();
}
