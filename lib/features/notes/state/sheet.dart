import 'package:flutter/material.dart';

import '../../../_services/hive/boxes.dart';

class SheetProvider with ChangeNotifier {
  bool isMin = globalBox.get('isSheetMin', defaultValue: true);

  void updateIsMinimized(bool min) {
    isMin = min;
    globalBox.put('isSheetMin', isMin);
    notifyListeners();
  }
}
