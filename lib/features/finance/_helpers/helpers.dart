import 'package:intl/intl.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_state/_providers.dart';

List getEntryKeys() {
  if (state.input.item.isSortAll()) {
    return state.input.item.subKeys();
  } else {
    String sortType = state.input.item.sortType();
    List entries = [];
    state.input.item.subKeys().forEach((key) {
      if (key.toString().substring(1, 2).contains(sortType)) {
        entries.add(key);
      }
    });

    return entries;
  }
}

String formatThousands(double amount) {
  return NumberFormat('#,##0.${"#" * 10}').format(amount).toCurrency();
}
