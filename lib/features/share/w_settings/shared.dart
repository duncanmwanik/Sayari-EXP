import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/_widgets.dart';
import 'copy_link.dart';
import 'header.dart';
import 'members.dart';
import 'policy.dart';

class ShareSettings extends StatelessWidget {
  const ShareSettings({
    super.key,
    this.showEditor = false,
    this.widget,
  });

  final bool showEditor;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isExpanded = input.item.isExpanded();

      return Visibility(
        visible: input.item.isShared(),
        child: Padding(
          padding: padMN('t'),
          child: Column(
            spacing: sw(),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: input.item.isLink() ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              //
              ShareItemHeader(),
              if (isExpanded) CopyLink(path: input.item.hasCustomLink() ? input.item.sharedCustomLink() : input.item.sharedLink()),
              if (isExpanded) SharePolicy(),
              if (isExpanded) ShareItemMembers(),
              if (widget != null && isExpanded) widget!,
              if (showEditor) AppEditor(placeholder: input.item.isLink() ? 'Type a short description here...' : null),
              //
            ],
          ),
        ),
      );
    });
  }
}
