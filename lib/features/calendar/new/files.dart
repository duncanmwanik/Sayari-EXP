import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/files/_helpers/get_files.dart';
import '../../../_widgets/files/file_list.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class Files extends StatelessWidget {
  const Files({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            children: [
              // icon
              Padding(
                padding: padL('r'),
                child: AppIcon(Icons.attach_file_rounded, faded: true, size: extra),
              ),
              //
              Planet(
                  onPressed: () async => await getFilesToUpload(),
                  slp: true,
                  noStyling: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.add_rounded, faded: true, size: 16),
                      tpw(),
                      AppText('Attach File', faded: true),
                    ],
                  )),
              //
            ],
          ),
          // files
          Padding(
            padding: padC('l30,t8'),
            child: FileList(item: input.item),
          ),
          //
        ],
      );
    });
  }
}
