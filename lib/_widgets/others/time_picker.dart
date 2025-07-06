import 'package:flutter/cupertino.dart';

import '../../_theme/variables.dart';
import '../buttons/planet.dart';

class AppTimePicker extends StatelessWidget {
  const AppTimePicker({
    super.key,
    this.initial,
    required this.onTimeChanged,
  });

  final DateTime? initial;
  final Function(DateTime) onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Planet(
      noStyling: true,
      padding: noPadding,
      maxWidth: 300,
      height: 100,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (dateTime) => onTimeChanged(dateTime),
        initialDateTime: initial,
      ),
    );
  }
}
