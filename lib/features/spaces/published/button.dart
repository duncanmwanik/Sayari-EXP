import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../share/_helpers/share.dart';
import '../_helpers/prepare.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Planet(
          onPressed: () {
            prepareSpaceForEdit(item);
            if (!item.isShared()) shareItem();
          },
          slp: true,
          srp: item.isShared(),
          noStyling: true,
          margin: padT('l'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(FontAwesome.earth_africa_solid, size: medium),
              spw(),
              //
              Flexible(child: AppText(item.isShared() ? 'Published' : 'Publish')),
              //
              if (item.isShared())
                AppIcon(
                  Icons.verified,
                  color: styler.accent(),
                  size: extra,
                  padding: padN('l'),
                ),
            ],
          ),
        ),
        //
        // if (item.isShared())
        //   Flexible(
        //     child: CopyLink(path: publishedSpaceLink(true)),
        //   ),
        //
      ],
    );
  }
}
