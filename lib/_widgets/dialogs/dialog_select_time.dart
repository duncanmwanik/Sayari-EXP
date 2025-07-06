import 'package:flutter/cupertino.dart';

import '../../_helpers/common/global.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/action.dart';
import '../others/scroll.dart';
import 'app_dialog.dart';

Future<void> showTimeDialog({
  String title = 'Choose time',
  DateTime? initial,
  required Function(DateTime) onTimeChanged,
}) async {
  DateTime dateTime = now();

  await showAppDialog(
    maxWidth: 280,
    contentPadding: noPadding,
    title: title,
    content: NoScrollBars(
      child: SingleChildScrollView(
        padding: padM('b'),
        child: SizedBox(
          height: 100,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (value) => dateTime = value,
            initialDateTime: initial,
          ),
        ),
      ),
    ),
    //
    actions: [
      ActionButton(isCancel: true),
      ActionButton(),
    ],
    //
  );

  onTimeChanged(dateTime);
}
