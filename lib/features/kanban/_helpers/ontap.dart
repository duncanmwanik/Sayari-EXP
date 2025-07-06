import '../../../_models/item.dart';
import '../../../_state/_providers.dart';

void onTapTask(Item item) {
  if (state.selection.isSelected(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item);
  }
}

void onLongPressTask(Item item) {
  if (state.selection.isSelected(item.id)) {
    state.selection.unSelect(item.id);
  } else {
    state.selection.select(item);
  }
}
