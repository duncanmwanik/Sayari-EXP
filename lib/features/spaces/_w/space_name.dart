import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/hive/boxes.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/common.dart';

class SpaceName extends StatelessWidget {
  const SpaceName({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: spaceNamesBox.listenable(),
        builder: (context, box, widget) {
          return AppText(
            size: normal,
            liveSpace() != noValue ? box.get(liveSpace(), defaultValue: 'Untitled') : 'Untitled',
            weight: FontWeight.w600,
          );
        });
  }
}
