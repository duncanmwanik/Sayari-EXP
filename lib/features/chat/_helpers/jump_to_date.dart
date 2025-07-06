import 'package:flutter/material.dart';

import '../../../_helpers/extentions/date_time.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../w/var.dart';

Future<void> jumpToChatDate(DateTime? date) async {
  if (date != null && local(features.chat).containsKey(date.datePart())) {
    chatScrollController.scrollTo(
      index: local(features.chat).keys.toList().reversed.toList().indexOf(date.datePart()),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
}
