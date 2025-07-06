import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import 'misc.dart';

Future<List> getChosenItems(List<String> types) async {
  try {
    Map data = local(features.docs).toMap();
    data.forEach((key, value) {
      if (key.toString().startsWith('i')) local(features.docs).delete(key);
      return;
    });
    List allIds = data.keys.toList();
    String currentTag = state.views.isTimeline() ? 'All' : state.views.tag;
    String order = state.views.order;
    List finalIds = [];

    // sort by title
    if (order.isTitleAZ() || order.isTitleZA()) {
      List<MapEntry> entries = data.entries.toList()
        ..sort((a, b) => (a.value[itemTitle] ?? 'Untitled').compareTo((b.value[itemTitle] ?? 'Untitled')));
      finalIds =
          order.isTitleZA() ? [for (MapEntry entry in entries) entry.key].reversed.toList() : [for (MapEntry entry in entries) entry.key];
    }
    // sort by creation time
    else {
      allIds.sort((a, b) => int.parse(data[a][itemTimestamp]).compareTo(int.parse(data[b][itemTimestamp])));
      finalIds = order.isOldest() ? allIds : allIds.reversed.toList();
    }

    List chosen = [];
    List pinned = [];

    for (var id in finalIds) {
      Item item = Item(id: id, data: data[id]);

      List labelList = splitList(item.tags());
      bool isPinned = item.isPinned();
      bool isTrashed = item.isTrashed();
      bool isArchived = item.isArchived();
      bool isChosenType = types.contains(item.typee());

      if (!isChosenType) continue;

      if (isPinned) pinned.add(id);

      if (currentTag == 'All') {
        if (!isTrashed && !isArchived) {
          chosen.add(id);
        }
      } else if (currentTag == 'Trash') {
        if (isTrashed) {
          chosen.add(id);
        }
      } else if (currentTag == 'Archive') {
        if (isArchived && !isTrashed) {
          chosen.add(id);
        }
      } else {
        if (labelList.contains(currentTag) && !isTrashed && !isArchived) {
          chosen.add(id);
        }
      }
    }

    for (var id in pinned) {
      if (chosen.contains(id)) {
        chosen.remove(id);
        chosen.insert(0, id);
      }
    }

    setItemCount(chosen.length);

    return chosen;
  } catch (e) {
    show(e);
    return [];
  }
}
