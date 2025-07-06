import 'package:intl/intl.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';

Future<void> pinMessage(Item item) async {
  await quickEdit(parent: features.chat, id: item.id, sid: item.sid, key: itemPinned, value: 1);
}

Future<void> unPinMessage(Item item) async {
  await quickEdit(action: 'd', parent: features.chat, id: item.id, sid: item.sid, key: itemPinned);
}

String getMessageTime(String timestamp) {
  try {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return DateFormat('h:mm a').format(date);
  } catch (e) {
    return 'Recently';
  }
}
