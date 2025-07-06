import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/hive/boxes.dart';
import '../../../_theme/spacing.dart';
import '_w/creator.dart';
import '_w/group_list.dart';
import '_w/loader.dart';
import '_w/space_list.dart';

class SpaceManager extends StatelessWidget {
  const SpaceManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userSpacesBox.listenable(),
        builder: (context, box, widget) {
          return ListView(
            shrinkWrap: true,
            padding: padS(),
            children: [
              //
              CreateOptions(),
              if (box.isEmpty) ManagerLoader(),
              GroupList(),
              SpaceList(),
              spph(),
              //
            ],
          );
        });
  }
}
