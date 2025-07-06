import 'package:flutter/material.dart';

import '../../../../_services/hive/boxes.dart';
import '../../../../_theme/spacing.dart';
import 'all_options.dart';
import 'space_tile.dart';
import 'tile.dart';

class SpaceList extends StatelessWidget {
  const SpaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Tile(
        title: 'All',
        count: userSpacesBox.length,
        iconData: Icons.folder_special_rounded,
        trailing: AllSpaceOptions(),
        initiallyExpanded: true,
        child: Wrap(
          runSpacing: th(),
          children: [
            for (String spaceId in userSpacesBox.keys) SpaceTile(spaceId: spaceId),
          ],
        ));
  }
}
