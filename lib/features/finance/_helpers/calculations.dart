import '../../../_models/item.dart';
import '../../../_variables/constants.dart';

double getTotalAmount(Map data, String type) {
  double total = 0;

  data.forEach((key, value) {
    if (key.toString().startsWith('$itemSubItem$type')) {
      double amount = value[itemAmount];
      total += amount;
    }
  });

  return total;
}

double getAllAmounts(Item item) {
  return getTotalAmount(item.data, itemIncome) + getTotalAmount(item.data, itemExpense) + getTotalAmount(item.data, itemSaving);
}
