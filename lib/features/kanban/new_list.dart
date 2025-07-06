import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/new_list.dart';

class NewList extends StatefulWidget {
  const NewList({super.key});

  @override
  State<NewList> createState() => _NewItemInputState();
}

class _NewItemInputState extends State<NewList> {
  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () => newList(),
      slp: true,
      margin: padN('br'),
      color: styler.appColor(0.8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.add_rounded, size: normal, faded: true),
          tpw(),
          Flexible(child: AppText('New List', size: tinySmall, faded: true)),
        ],
      ),
    );
  }
}
