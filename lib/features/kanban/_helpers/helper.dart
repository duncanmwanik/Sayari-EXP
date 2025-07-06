import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';

Map getSubItems(Map data) {
  Map map = {...data};

  data.forEach((key, value) {
    if (!key.toString().startsWith('i')) map.remove(key);
  });

  return map;
}

void editSubItem(Item task) {
  state.input.update(parentKey: task.id, task.sid, task.data);
  closeDialog();
}
