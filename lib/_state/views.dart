import 'package:flutter/material.dart';

import '../_services/hive/boxes.dart';
import '../_theme/breakpoints.dart';
import '../_variables/constants.dart';
import '../_variables/features.dart';
import '../features/spaces/_helpers/common.dart';
import '_providers.dart';

class ViewsProvider with ChangeNotifier {
  // home view
  String view = globalBox.get('view', defaultValue: features.timeline);
  bool isTimeline() => view == features.timeline;
  bool isCalendar() => view == features.calendar;
  bool isDocs() => view == features.docs;
  bool isChat() => view == features.chat;
  bool isPlay() => view == features.ghost;
  bool isAlternateView() => isSmallPC() && docLayout.isAlternate();
  bool isExplore() => view == features.explore;

  void setView(String type) {
    view = type;
    globalBox.put('view', type);
    state.selection.clear();
    notifyListeners();
  }

  // doc view
  String docView = globalBox.get('docView', defaultValue: features.notes);
  void updateDocView(String type) {
    docView = type;
    globalBox.put('docView', type);
    layout = globalBox.get('${liveSpace()}_layout_$type', defaultValue: type.isKanban() ? 'column' : 'grid');
    notifyListeners();
  }

  // doc layout
  String docLayout = globalBox.get('${liveSpace()}_$docLayoutType', defaultValue: docLayoutNormal);
  void updateDocLayout(String type) {
    docLayout = type;
    globalBox.put('${liveSpace()}_$docLayoutType', type);
    notifyListeners();
  }

  // layout
  String layout = globalBox.get(
    '${liveSpace()}_layout_${globalBox.get('docView', defaultValue: features.notes)}',
    defaultValue: (globalBox.get('docView', defaultValue: features.notes) == features.kanban) ? 'column' : 'grid',
  );
  bool isGrid() => layout == 'grid';
  bool isRow() => layout == 'row';
  bool isColumn() => layout == 'column';
  bool isList() => layout == 'list';

  void setLayout(String type, String newLayout) {
    layout = newLayout;
    globalBox.put('${liveSpace()}_layout_$type', newLayout);
    notifyListeners();
  }

  // tag
  String tag = globalBox.get('${liveSpace()}_$selectedTag', defaultValue: 'All');
  void updateSelectedTag(String label) {
    tag = label;
    globalBox.put('${liveSpace()}_$selectedTag', label);
    notifyListeners();
  }

  // order
  String order = globalBox.get('${liveSpace()}_$orderType', defaultValue: orderTypeNewest);
  void updateOrder(String type) {
    order = type;
    globalBox.put('${liveSpace()}_$orderType', type);
    notifyListeners();
  }
}
