import 'package:hive_ce/hive.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';

Future<void> orderItems({
  required String oldItemId,
  required String newItemId,
  required int itemsLength,
  required int oldIndex,
  required int newIndex,
}) async {
  try {
    Box box = local(features.docs);
    // because the original ids list is reverse, we reverse the sign of the change(1) as well
    String newOrder = (int.parse(box.get(newItemId)[itemOrder]) + (oldIndex < newIndex ? -1 : 1)).toString();
    show(
        'New item order: $oldIndex >> $newIndex ------> ${box.get(oldItemId)[itemOrder]} >> ${box.get(newItemId)[itemOrder]} >>> $newOrder');
    await quickEdit(parent: features.docs, id: oldItemId, key: itemOrder, value: newOrder);
  } catch (e) {
    logError('orderItems-$oldItemId', e);
  }
}

Future<void> orderSubItem({
  String? parent,
  required String itemId,
  required String oldItemId,
  required String newItemId,
  required int itemsLength,
  required int oldIndex,
  required int newIndex,
  bool applyIndexFix = false,
}) async {
  try {
    if (applyIndexFix) {
      if (newIndex > itemsLength) newIndex = itemsLength;
      if (oldIndex < newIndex) newIndex--;
    }

    Box box = local(parent ?? features.docs);
    String oldItemOrder = box.get(itemId)[oldItemId][itemOrder];
    String newItemOrder = box.get(itemId)[newItemId][itemOrder];
    // because the original ids list is reverse, we reverse the sign of the change(1) as well
    String newOrder = (int.parse(newItemOrder) + (oldIndex < newIndex ? -1 : 1)).toString();
    show('${box.get(itemId)[oldItemId][itemTitle]} >> ${box.get(itemId)[newItemId][itemTitle]}');
    show('New subitem order: $oldIndex >> $newIndex --- $oldItemOrder >> $newItemOrder : $newOrder');
    await quickEdit(parent: parent ?? features.docs, id: itemId, sid: oldItemId, key: itemOrder, value: newOrder);
  } catch (e) {
    logError('orderSubItem-$itemId-$oldItemId', e);
  }
}
