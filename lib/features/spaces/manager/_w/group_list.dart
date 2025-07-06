import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../../_services/hive/boxes.dart';
import 'group_tile.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userGroupsBox.listenable(),
        builder: (context, box, widget) {
          return Wrap(
            children: [
              //
              for (String groupId in box.keys)
                GroupTile(
                  groupId: groupId,
                  groupData: box.get(groupId, defaultValue: {}),
                ),
              //
            ],
          );
        });
  }
}
