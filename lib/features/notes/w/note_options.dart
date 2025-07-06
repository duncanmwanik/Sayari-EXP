import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_services/hive/boxes.dart';
import '../../tags/switcher.dart';
import '../layout/button.dart';
import '../state/active.dart';

class NoteOptions extends StatelessWidget {
  const NoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['showPanelOptions']),
        builder: (context, box, w) {
          return Consumer<DocProvider>(builder: (context, doc, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                Flexible(child: TagSwitcher()),
                LayoutButton(),
                //
              ],
            );
          });
        });
  }
}
