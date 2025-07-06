import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../others/icons.dart';
import '../others/text.dart';

class FileListOverview extends StatelessWidget {
  const FileListOverview({super.key, required this.sitem, required this.item});

  final Item item;
  final Item sitem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padM('t'),
      child: Planet(
        svp: true,
        slp: true,
        srp: true,
        noStyling: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(Icons.folder_open_rounded, size: medium, faded: true),
            tpw(),
            AppText('${sitem.files().length}', size: tiny, faded: true),
          ],
        ),
      ),
    );
  }
}
