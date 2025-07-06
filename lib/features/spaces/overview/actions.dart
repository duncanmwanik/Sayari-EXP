import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/divider.dart';
import '../../../_widgets/others/divider_vertical.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/prepare.dart';
import '../published/button.dart';

class SpaceActions extends StatelessWidget {
  const SpaceActions({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padLL('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('Actions', size: small, faded: true),
          AppDivider(height: mh()),
          Wrap(
            runSpacing: sw(),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Planet(
                onPressed: () => prepareSpaceForEdit(item),
                slp: true,
                noStyling: true,
                iconSize: small,
                content: 'Edit',
                leading: editIcon,
              ),
              AppSeparator(),
              PublishButton(item: item),
            ],
          ),
        ],
      ),
    );
  }
}
