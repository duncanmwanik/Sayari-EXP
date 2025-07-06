import 'package:flutter/material.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/spacing.dart';
import '../buttons/action.dart';
import '../others/text.dart';
import 'menu_item.dart';
import 'model.dart';

Menu confirmationMenu({
  String? title,
  String? content,
  String? yeslabel,
  required Function() onAccept,
}) {
  return Menu(items: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        MenuItem(label: title ?? 'Delete item?'),
        sph(),
        //
        if (content != null)
          Flexible(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: AppText(content, faded: true),
          )),
        //
        mph(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButton(isCancel: true, minWidth: 100),
            ActionButton(
              label: yeslabel ?? 'Delete',
              minWidth: 100,
              onPressed: () {
                popWhatsOnTop();
                onAccept();
              },
            ),
          ],
        ),
      ],
    ),
  ]);
}
