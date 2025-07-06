import 'package:flutter/material.dart';

import '../../_theme/variables.dart';
import '../../_widgets/others/scroll.dart';
import '../../_widgets/sheets/sheet.dart';
import 'ai_bar.dart';

Future<void> showAISheet() async {
  await showAppBottomSheet(
    //
    header: AIBar(),
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
