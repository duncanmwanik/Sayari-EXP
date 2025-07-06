import 'package:flutter/material.dart';

import '../../../../_theme/helpers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/loader.dart';
import '../../../../_widgets/others/other.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/common.dart';
import '../../_helpers/names.dart';
import '../../_helpers/select.dart';
import 'space_options.dart';

class SpaceTile extends StatefulWidget {
  const SpaceTile({super.key, required this.spaceId, this.groupId = ''});

  final String spaceId;
  final String groupId;

  @override
  State<SpaceTile> createState() => _SpaceTileState();
}

class _SpaceTileState extends State<SpaceTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.spaceId == liveSpace();
    bool isDefault = isDefaultSpace(widget.spaceId);

    return FutureBuilder(
        future: getSpaceName(widget.spaceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return NoWidget();
            } else if (snapshot.hasData) {
              final spaceName = snapshot.data as String;

              return Planet(
                onPressed: isLoading
                    ? () {}
                    : () async {
                        setState(() => isLoading = true);
                        await selectNewSpace(widget.spaceId);
                        setState(() => isLoading = false);
                      },
                color: styler.appColor(1),
                padding: padC('l10,r2'),
                height: 32,
                blurred: isImage(),
                child: Row(
                  children: [
                    //
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // name
                          Expanded(
                            child: AppText(
                              spaceName,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          spw(),
                          // indicator, if space is selected
                          if (isSelected)
                            Padding(
                              padding: padC(isDefault ? 'r10' : 'r2'),
                              child: AppIcon(Icons.done_rounded, size: medium, color: styler.accent()),
                            ),
                          // default space
                          if (isDefault)
                            Padding(
                              padding: padC('r2'),
                              child: AppIcon(Icons.verified, size: small, extraFaded: true),
                            ),
                          //
                        ],
                      ),
                    ),
                    // loading
                    if (isLoading)
                      Padding(
                        padding: padC('l5,r6'),
                        child: AppLoader(
                          size: medium,
                          color: isImage() ? white : styler.accent(),
                        ),
                      ),
                    // options
                    if (!isLoading)
                      SpaceOptions(
                        spaceId: widget.spaceId,
                        spaceName: spaceName,
                        groupId: widget.groupId,
                      ),
                    //
                  ],
                ),
              );
            }
          }
          return NoWidget();
        });
  }
}
