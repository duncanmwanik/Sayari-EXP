import '../../../_helpers/common/global.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../share/_helpers/share.dart';
import '../../tags/var/tag_model.dart';
import '../../user/_helpers/helpers.dart';
import '../sheet.dart';

Future<void> createDoc(String type) async {
  state.editor.reset();

  Item item = Item(
    isNew: true,
    parent: features.docs,
    type: type,
    id: getUniqueId(),
    data: {
      itemType: type,
      itemOrder: getUniqueId(),
      itemTimestamp: getUniqueId(),
      if (type.isBooking()) itemTitle: 'Book a session with ${liveUserName()}',
      if (!Tag(id: state.views.tag).isDefault()) itemTags: state.views.tag,
    },
  );
  state.input.set(item);
  // share item
  if (item.isBooking() || item.isLink()) shareItem();

  await showDocBottomSheet(item);
}

Future<void> editNote(Item item) async {
  state.input.set(item);
  await state.editor.reset(blocks: item.content());
  await showDocBottomSheet(item);
}

Future<void> chooseNote(Item item) async {
  state.input.set(item);
  await state.editor.reset(blocks: item.content());
  state.doc.updateDoc(item);
}
