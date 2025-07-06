import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/_widgets.dart';
import 'about.dart';
import 'files.dart';
import 'header.dart';
import 'lead.dart';
import 'reminders.dart';
import 'time.dart';
import 'title.dart';
import 'venue.dart';

Future<void> showSessionDialog() async {
  bool isNew = state.input.item.isNew;

  await showAppDialog(
    showClose: false,
    titlePadding: noPadding,
    title: NewSessionHeader(),
    content: NoScrollBars(
      child: SingleChildScrollView(
        padding: padS('lrb'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            NewSessionTitle(isNew: isNew),
            tph(),
            DateTimePicker(type: itemStart),
            sph(),
            DateTimePicker(type: itemEnd),
            sph(),
            Reminders(),
            sph(),
            Lead(),
            Venue(),
            About(),
            sph(),
            Files(),
            elph()
            //
          ],
        ),
      ),
    ),
    //
  );
}
