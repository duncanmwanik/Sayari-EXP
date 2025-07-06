import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/sheets/sheet.dart';
import '../published/details.dart';
import 'date.dart';
import 'description.dart';
import 'header.dart';
import 'title.dart';

Future<void> showSpaceSheet() async {
  await showAppBottomSheet(
    isShort: state.input.item.isNew,
    header: Header(),
    //
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          TitleInput(),
          sph(),
          Description(),
          msph(),
          Dates(showIcon: true),
          mph(),
          PublishedSpace(),
          lph(),
          //
        ],
      ),
    ),
    //
  );
}
