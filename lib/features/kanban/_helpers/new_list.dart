import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/common/helpers.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../var/var.dart';

void newList() async {
  String id = getUniqueId();
  state.input.update('$itemSubItem$id', {itemOrder: id});
  await delay(100);
  kanbanScrollController?.animateTo(
    kanbanScrollController!.position.maxScrollExtent,
    duration: Duration(milliseconds: 200),
    curve: Curves.easeOut,
  );
}
