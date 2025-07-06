import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/editor/editor.dart';

class ItemEditorOverview extends StatelessWidget {
  const ItemEditorOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Planet(
      margin: padM('t'),
      padding: padC('l4,r4'),
      color: transparent,
      child: AppEditor(
        json: item.content(),
        editable: false,
        faded: true,
        scale: 0.7,
      ),
    );
  }
}
