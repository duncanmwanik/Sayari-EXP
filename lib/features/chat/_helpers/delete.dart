import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/sync/delete_item.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';

Future<void> deleteMessage(Item item, {bool forAll = false}) async {
  try {
    showConfirmationDialog(
      title: 'Delete message for ${forAll ? 'all' : 'me'}?',
      yeslabel: 'Delete',
      onAccept: () async {
        Box box = local(features.chat);
        Map dateChats = box.get(item.id, defaultValue: {});
        dateChats.remove(item.sid);
        box.put(item.id, dateChats);
        await pendingBox.delete(item.sid);
        if (forAll) await deleteItemForever(item);
      },
    );
  } catch (e) {
    //
  }
}
