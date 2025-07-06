import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_variables/constants.dart';

class ShareProvider with ChangeNotifier {
  String type = '';
  String spaceId = '';
  String link = '';
  bool isSharedView = false;
  Item item = Item.empty();

  void set(String linkPath, String type_, String space, Item item_) {
    link = '$sayariDefaultPath/$linkPath';
    type = type_;
    item = item_;
    spaceId = space;
    isSharedView = true;
  }

  void unset() => isSharedView = false;
}
