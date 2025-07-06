import 'package:flutter/cupertino.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/variables.dart';
import '../datepicker/sfcalendar.dart';
import '../others/scroll.dart';
import 'app_dialog.dart';

Future<List> showDateDialog({
  String title = 'Select a date',
  String actionLabel = 'Done',
  String? initialDate,
  List initialDates = const [],
  bool isMultiple = false,
  bool showTitle = true,
  Function(DateTime)? onSelect,
  Function(List)? onDone,
}) async {
  List selectedDates = [];

  await showAppDialog(
    maxWidth: 280,
    contentPadding: noPadding,
    title: showTitle ? title : null,
    titlePadding: showTitle ? null : noPadding,
    content: NoScrollBars(
      child: SingleChildScrollView(
        child: SfCalendar(
          initialDate: initialDate,
          initialDates: initialDates,
          isMultiple: isMultiple,
          selectedDates: selectedDates,
          onSelect: onSelect,
        ),
      ),
    ),
  );

  popWhatsOnTop(todo: onDone!(selectedDates));

  return selectedDates;
}
