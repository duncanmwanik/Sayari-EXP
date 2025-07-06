import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_models/date.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../new/new_dialog.dart';
import 'helpers.dart';

Future<void> createSession({DateItem? date, int? hour, Item? item}) async {
  state.input.set(
    Item(
      isNew: true,
      label: 'New Session',
      parent: features.calendar,
      type: features.calendar,
      id: date != null ? date.datePart() : now().datePart(),
      sid: getUniqueId(),
      data: {
        itemType: 'Session',
        itemColor: '0',
        itemReminder: '30.m',
        itemStart: getNewSessionTime(date: date, hour: hour, offset: 1),
        itemEnd: getNewSessionTime(date: date, hour: hour, offset: 2),
      },
    ),
  );

  if (item != null) {
    state.input.item.label = 'Duplicate Session';
    state.input.item.data = {...item.data};
    item.data[itemStart] = getNewSessionTime(offset: 1);
    item.data[itemEnd] = getNewSessionTime(offset: 2);
  }

  showSessionDialog();
}

Future<void> editSession(Item item) async {
  item.label = 'Edit Session';
  state.input.set(item);
  showSessionDialog();
}
