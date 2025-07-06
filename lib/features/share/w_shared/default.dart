import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import 'escape.dart';

class ShareDefault extends StatelessWidget {
  const ShareDefault({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          lph(),
          AppImage('sayari.png', size: imageSizeSmall),
          mlph(),
          Flexible(
              child: AppText(
            faded: true,
            label ?? "We couldn't find what you're looking for...",
            textAlign: TextAlign.center,
          )),
          mlph(),
          ShareEscape(),
          mph(),
        ],
      ),
    );
  }
}
