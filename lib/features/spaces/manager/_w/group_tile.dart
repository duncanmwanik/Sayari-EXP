import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_variables/constants.dart';
import 'group_options.dart';
import 'space_tile.dart';
import 'tile.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    super.key,
    required this.groupId,
    required this.groupData,
  });

  final String groupId;
  final Map groupData;

  @override
  Widget build(BuildContext context) {
    String groupName = groupData[itemTitle] ?? 'Untitled';
    List spaceIds = groupData.keys.where((key) => key != itemTitle).toList();

    return Tile(
      title: groupName,
      count: spaceIds.length,
      trailing: GroupOptions(groupId, groupName),
      child: Wrap(
        runSpacing: th(),
        children: [
          for (String spaceId in spaceIds) SpaceTile(spaceId: spaceId, groupId: groupId),
        ],
      ),
    );
  }
}
