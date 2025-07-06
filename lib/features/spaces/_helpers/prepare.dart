import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/features.dart';
import '../new_space/sheet.dart';

void prepareSpaceForCreation() {
  closeDrawer();
  state.input.set(Item(isInput: true, isNew: true, type: features.space, data: {}));
  showSpaceSheet();
}

void prepareSpaceForEdit(Item item) {
  state.input.set(item);
  showSpaceSheet();
}
