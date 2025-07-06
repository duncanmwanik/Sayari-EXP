import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';

Future<List> getListIds([Item? doc]) async {
  try {
    Item source = doc ?? state.input.item;
    List allIds = source.subKeys();
    allIds.sort(
      (a, b) => int.parse(source.data[a][itemOrder]).compareTo(int.parse(source.data[b][itemOrder])),
    );

    return allIds;
  } catch (e) {
    return [];
  }
}
