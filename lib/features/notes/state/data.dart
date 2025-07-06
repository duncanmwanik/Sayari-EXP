import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  Map data = {};
  List previousIds = [];
  List ids = [];

  // Future<void> initialize(String type) async {
  //   ids = await getChosenItems(type);
  //   previousIds = ids;
  //   local(features.docs).listenable().addListener(() => update(type));
  //   local(features.docs).listenable().addListener(() => update(type));
  // }

  // Future<void> update(String type) async {
  //   ids = await getChosenItems(type);
  //   if (!ListEquality().equals(ids, previousIds)) {
  //     previousIds = [...ids];
  //     globalBox.put('${liveSpace()}_${type}_itemCount', ids.length);
  //     notifyListeners();
  //   }
  // }

  void clear() => ids.clear();

  bool isEmpty() => ids.isEmpty;
}
