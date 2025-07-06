import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../../share/_helpers/share.dart';
import '../../share/w_settings/shared.dart';
import 'cover.dart';

class PublishedSpace extends StatefulWidget {
  const PublishedSpace({super.key, this.showIcon = true});

  final bool showIcon;

  @override
  State<PublishedSpace> createState() => _PublishSpaceState();
}

class _PublishSpaceState extends State<PublishedSpace> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: input.item.isShared(),
        child: Padding(
          padding: padC('l26'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              ShareSettings(
                showEditor: false,
                widget: Planet(
                  onPressed: () => unshareItem(
                    title: 'Unpublish <b>${input.item.title()}</b>?',
                    yeslabel: 'Unpublish',
                    todo: () => input.removeMatch(itemFileCover),
                  ),
                  margin: padMS('t'),
                  child: AppText('Unpublish', color: red),
                ),
              ),
              // cover image
              PublishedSpaceCover(),
              //
            ],
          ),
        ),
      );
    });
  }
}
