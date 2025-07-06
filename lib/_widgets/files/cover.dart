import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../menu/menu_item.dart';
import '../menu/model.dart';
import '../rebuilders/input.dart';
import '_helpers/get_files.dart';
import 'image.dart';
import 'viewer.dart';

class Cover extends StatelessWidget {
  const Cover({
    super.key,
    this.parentKey = '',
    this.size,
    this.item,
  });

  final String parentKey;
  final double? size;
  final Item? item;

  @override
  Widget build(BuildContext context) {
    return InputListener(
      item: item,
      builder: (input, item, enabled) {
        String coverId = item.coverId(parentKey);
        String coverName = item.coverName(parentKey);
        bool hasLinkDp = coverId.isNotEmpty;

        return Planet(
          enabled: enabled,
          onPressed: hasLinkDp
              ? null
              : () async {
                  await getFilesToUpload(
                    single: true,
                    imagesOnly: true,
                    cover: true,
                    addToInput: false,
                    onDone: (stash) {
                      input.update(
                        parentKey: parentKey,
                        stash.first().id,
                        stash.first().name,
                      );
                    },
                  );
                },
          menu: hasLinkDp
              ? Menu(
                  items: [
                    MenuItem(
                      label: 'Edit Image',
                      leading: editIcon,
                      onTap: () async {
                        await getFilesToUpload(
                          single: true,
                          imagesOnly: true,
                          cover: true,
                          addToInput: false,
                          onDone: (stash) {
                            input.remove(coverId, parentKey: parentKey); // removes previous coverId
                            input.update(
                              parentKey: parentKey,
                              stash.first().id,
                              stash.first().name,
                            );
                          },
                        );
                      },
                    ),
                    if (coverId.isNotEmpty)
                      MenuItem(
                        label: 'View Image',
                        leading: Icons.image,
                        onTap: () => showImageViewer(images: {coverId: coverName}),
                      ),
                    if (coverId.isNotEmpty)
                      MenuItem(
                        label: 'Remove Image',
                        leading: Icons.close,
                        onTap: () => input.remove(coverId, parentKey: parentKey),
                      ),
                  ],
                )
              : null,
          padding: padT(),
          isSquare: true,
          noStyling: true,
          showBorder: true,
          radius: borderRadiusCrazy,
          child: ImageFile(
            coverId,
            coverName,
            images: {coverId: coverName},
            ignore: true,
            offline: true,
            showOptions: false,
            radius: borderRadiusCrazy,
            size: size ?? 100,
            color: styler.appColor(0.5),
          ),
        );
      },
    );
  }
}
