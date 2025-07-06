import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';

Future<List> getChosenItemsId(String id) async {
  try {
    Item item = Item(id: id, data: local(features.docs).get(id));

    List allIds = item.subKeys();
    allIds.sort((a, b) => int.parse(item.data[a][itemTimestamp]).compareTo(int.parse(item.data[b][itemTimestamp])));

    return allIds;
  } catch (e) {
    return [];
  }
}
