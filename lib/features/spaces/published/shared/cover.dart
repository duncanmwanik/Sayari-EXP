import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../_services/cloud/realtime.dart';
import '../../../../_state/_providers.dart';
import '../../../../_theme/breakpoints.dart';
import '../../../../_variables/constants.dart';
import '../../../../_widgets/files/image.dart';

class PublishedCover extends StatelessWidget {
  const PublishedCover({super.key});

  @override
  Widget build(BuildContext context) {
    String spaceId = state.share.spaceId;
    String fileId = state.share.item.coverId();

    return FutureBuilder(
        future: cloud.getData(db: spaces, '$spaceId/info/$fileId'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ImageFile(
                '',
                '',
                height: (!isSmallPC() ? 15.h : 20.h) / 0.7092,
                width: !isSmallPC() ? 15.h : 20.h,
                showOptions: false,
              );
            } else if (snapshot.hasData) {
              String fileName = snapshot.data!.value != null ? snapshot.data!.value as String : '';

              return ImageFile(
                fileId,
                fileName,
                images: {fileId: fileName},
                height: (!isSmallPC() ? 15.h : 20.h) / 0.7092,
                width: !isSmallPC() ? 15.h : 20.h,
                showOptions: false,
              );
            }
          }
          return ImageFile(
            '',
            '',
            height: (!isSmallPC() ? 15.h : 20.h) / 0.7092,
            width: !isSmallPC() ? 15.h : 20.h,
            showOptions: false,
          );
        });
  }
}
