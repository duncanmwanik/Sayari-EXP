import 'package:flutter/material.dart';

import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/date.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/divider.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

Future<void> showChangeBookingDateDialog({
  required String name,
  required String time,
  required String date,
  required Function(String newDate, String newTime, bool sendEmail) onDone,
}) async {
  await showAppDialog(
    //
    title: 'Change Date & Time',
    //
    content: Changer(name: name, date: date, time: time, onDone: onDone),
    //
  );
}

class Changer extends StatefulWidget {
  const Changer({super.key, required this.name, required this.date, required this.time, required this.onDone});
  final String name;
  final String date;
  final String time;
  final Function(String newDate, String newTime, bool sendEmail) onDone;

  @override
  State<Changer> createState() => _ChangerState();
}

class _ChangerState extends State<Changer> {
  String newDate = '';
  String newTime = '';
  bool sendEmail = true;

  @override
  void initState() {
    setState(() {
      newDate = widget.date;
      newTime = widget.time;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOCHECK
          Planet(
            onPressed: () => showDateDialog(
              title: 'Choose New Date',
              initialDate: newDate,
              onSelect: (selectedDate) => popWhatsOnTop(todo: () => setState(() => newDate = selectedDate.datePart())),
            ),
            noStyling: true,
            radius: borderRadiusSmall,
            child: Row(
              children: [
                AppIcon(editIcon, size: 16, faded: true),
                mpw(),
                AppText(DateItem(newDate).dateInfo(), weight: FontWeight.bold, faded: true),
              ],
            ),
          ),
          //
          AppDivider(height: sh()),
          //
          Planet(
            onPressed: () async {
              await showTimePicker(
                context: context,
                cancelText: 'Cancel',
                confirmText: 'Done',
                initialTime: TimeOfDay(hour: 9, minute: 0),
              ).then((time) {
                if (time != null) {
                  setState(() => newTime = '${time.hour}:${time.minute}');
                }
                return null;
              });
            },
            noStyling: true,
            radius: borderRadiusSmall,
            child: Row(
              children: [
                AppIcon(Icons.access_time_rounded, size: 16, faded: true),
                mpw(),
                AppText(newTime, weight: FontWeight.bold, faded: true),
              ],
            ),
          ),
          //
          AppDivider(height: sh()),
          //
          Planet(
            onPressed: () => setState(() => sendEmail = !sendEmail),
            noStyling: true,
            radius: borderRadiusSmall,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: AppText('Update <b>${widget.name}</b> on changes')),
                AppCheckBox(
                  isChecked: sendEmail,
                  onTap: () => setState(() => sendEmail = !sendEmail),
                ),
              ],
            ),
          ),
          //
          mph(),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(isCancel: true),
              mpw(),
              ActionButton(
                label: 'Save',
                onPressed: () {
                  popWhatsOnTop();
                  widget.onDone(newDate, newTime, sendEmail);
                },
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}
