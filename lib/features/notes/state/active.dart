import 'package:flutter/material.dart';

import '../../../_models/item.dart';

class DocProvider with ChangeNotifier {
  Item item = Item();

  void updateDoc(Item newItem) {
    item = newItem;
    notifyListeners();
  }

  void reset() {
    item = Item();
    notifyListeners();
  }
}
