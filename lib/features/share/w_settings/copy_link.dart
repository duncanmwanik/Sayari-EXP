import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/clipboard.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'change_link.dart';

class CopyLink extends StatelessWidget {
  const CopyLink({
    super.key,
    required this.path,
    this.description,
  });

  final String path;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Row(
        spacing: sw(),
        mainAxisSize: MainAxisSize.min,
        children: [
          // link
          Flexible(
            child: Planet(
              onPressed: () async => await copyText(path, description: description ?? 'Copied link.'),
              slp: true,
              svp: true,
              showBorder: true,
              maxWidth: 300,
              minHeight: 26,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.link, size: mediumSmall, faded: true),
                  spw(),
                  Flexible(child: AppText(path, overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ),
          //
          Planet(
            onPressed: () => showChangeLinkDialog(),
            isSquare: true,
            showBorder: true,
            child: AppIcon(editIcon, size: mediumSmall, faded: true),
          ),
          // copy
          Planet(
            onPressed: () async => await copyText(path, description: description ?? 'Copied link.'),
            isSquare: true,
            showBorder: true,
            height: 26,
            width: 26,
            child: AppIcon(Icons.copy, faded: true, size: mediumSmall),
          ),
        ],
      );
    });
  }
}
