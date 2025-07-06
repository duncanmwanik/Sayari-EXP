import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/sheet.dart';

Future<void> showSavedSheet() async {
  await showAppBottomSheet(
    isFull: true,
    //
    header: Row(
      children: [
        AppCloseButton(),
        spw(),
        Expanded(child: AppText('Saved', size: normal)),
      ],
    ),
    //
    content: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: webMaxWidth),
      child: NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              //
            ],
          ),
        ),
      ),
    ),
    //
  );
}
