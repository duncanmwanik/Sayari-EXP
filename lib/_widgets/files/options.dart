import 'package:flutter/material.dart';

import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../menu/menu_item.dart';
import '../menu/model.dart';
import '../others/icons.dart';
import '_helpers/download.dart';
import '_helpers/helper.dart';

class FileOptions extends StatelessWidget {
  const FileOptions(this.fileId, this.fileName, {super.key});

  final String fileId;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(items: [
        //
        // if (!state.views.isChat())
        //   MenuItem(
        //     onTap: () => state.input.update('w', fileId),
        //     label: 'Make Cover',
        //     leading: Icons.push_pin_outlined,
        //   ),
        //
        MenuItem(
          onTap: () async => await downloadFile(id: fileId, name: fileName),
          label: 'Download ${isImageFile(fileName) ? 'Image' : 'File'}',
          leading: Icons.download_rounded,
        ),
        //
        MenuItem(
          onTap: () => state.input.remove(fileId),
          label: 'Remove ${isImageFile(fileName) ? 'Image' : 'File'}',
          leading: Icons.delete_rounded,
        ),
        //
      ]),
      isSquare: isImageFile(fileName),
      padding: pad(p: 3),
      color: styler.appColor(3),
      noStyling: !isImageFile(fileName),
      showBorder: isImageFile(fileName),
      child: AppIcon(moreIcon),
    );
  }
}
