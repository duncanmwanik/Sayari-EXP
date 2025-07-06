import 'dart:math';

import 'package:flutter/material.dart';

import '../_helpers/extentions/map.dart';
import '../_models/item.dart';
import '../_services/hive/boxes.dart';

class InputProvider with ChangeNotifier {
  Item item = Item.empty();
  Map previousData = {};

  void set(Item itm) {
    item = itm;
    item.isInput = true;
    previousData = item.data.newMap();
    notifyListeners();
  }

  void update(String key, var value, {String parentKey = '', bool notify = true}) {
    if (parentKey.isNotEmpty) {
      Map subData = item.data[parentKey] ?? {};
      subData[key] = value;
      item.data[parentKey] = subData;
    } else {
      item.data[key] = value;
    }

    if (notify) rebuildBox.put(key, Random().nextInt(9999));
    if (notify) notifyListeners();
  }

  void remove(String key, {String parentKey = ''}) {
    if (parentKey.isNotEmpty) {
      Map subData = item.data[parentKey] ?? {};
      subData.remove(key);
      item.data[parentKey] = subData;
    } else {
      item.data.remove(key);
    }

    notifyListeners();
  }

  void addAll(Map all) {
    item.data.addAll(all);
    rebuildBox.putAll(all);
    notifyListeners();
  }

  void removeMatch(String match, {bool removeValues = false}) {
    item.data.removeWhere((key, value) => key.toString().startsWith(match));

    if (removeValues) {
      item.data.removeWhere((key, value) => value.toString().startsWith(match));
    }

    notifyListeners();
  }

  void clear() {
    item = Item.empty();
    previousData = {};
  }

  // for calendar

  List selectedWeekDays = [];

  void updateSelectedWeekDays(String action, int weekday) {
    action == 'add' ? selectedWeekDays.add(weekday) : selectedWeekDays.remove(weekday);
    notifyListeners();
  }
}
