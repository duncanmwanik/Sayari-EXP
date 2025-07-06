import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../_state/input.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/files/_helpers/get_files.dart';
import '../../../_widgets/files/image.dart';
import '../../../_widgets/files/viewer.dart';
import '../../../_widgets/menu/confirmation.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';

class PublishedSpaceCover extends StatefulWidget {
  const PublishedSpaceCover({super.key, this.showIcon = true});

  final bool showIcon;

  @override
  State<PublishedSpaceCover> createState() => _PublishSpaceState();
}

class _PublishSpaceState extends State<PublishedSpaceCover> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      String coverId = input.item.coverId();
      String coverName = input.item.coverName();

      return Planet(
        menu: Menu(
          items: [
            //
            MenuItem(
                leading: editIcon,
                label: 'Edit Cover',
                onTap: () async => await getFilesToUpload(
                      single: true,
                      imagesOnly: true,
                      cover: true,
                      onDone: (stash) {
                        input.remove(coverId);
                      },
                    )),
            if (coverId.isNotEmpty)
              MenuItem(leading: Icons.image, label: 'View Cover', onTap: () => showImageViewer(images: {coverId: coverName})),
            //
            if (coverId.isNotEmpty)
              MenuItem(
                  leading: Icons.delete_outline,
                  label: 'Remove Cover',
                  menu: confirmationMenu(
                    title: 'Remove cover?',
                    yeslabel: 'Remove',
                    onAccept: () {
                      input.removeMatch(itemFileCover);
                    },
                  ))
            //
          ],
        ),
        noStyling: true,
        margin: padL('t'),
        padding: noPadding,
        child: ImageFile(
          coverId,
          coverName,
          images: {coverId: coverName},
          height: (!isSmallPC() ? 15.h : 20.h) / 0.7092,
          width: (!isSmallPC() ? 15.h : 20.h),
          fit: BoxFit.cover,
          showOptions: false,
          ignore: true,
        ),
      );
    });
  }
}
