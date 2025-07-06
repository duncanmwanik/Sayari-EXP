import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/editor/editor.dart';
import '../../../_widgets/files/image.dart';
import '../../../_widgets/others/text.dart';
import '../../share/w_shared/socials.dart';

class LinksIntro extends StatelessWidget {
  const LinksIntro({super.key});

  @override
  Widget build(BuildContext context) {
    state.editor.reset(blocks: state.share.item.content());
    String coverId = state.share.item.coverId();
    String coverName = state.share.item.coverName();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // cover image
        SizedBox(
          width: 110,
          height: 110,
          child: Stack(
            children: [
              Planet(
                padding: EdgeInsets.zero,
                radius: borderRadiusCrazy,
                child: ImageFile(
                  coverId,
                  coverName,
                  images: {coverId: coverName},
                  size: 100,
                  radius: 500,
                  showOptions: false,
                  ignore: true,
                  hoverColor: transparent,
                ),
              ),
              // share
              Align(
                alignment: Alignment.bottomRight,
                child: ShareToSocials(
                  title: state.share.item.title(),
                  link: state.share.link,
                  isProfile: true,
                  isShareIcon: false,
                ),
              )
            ],
          ),
        ),
        //
        sph(),
        //
        AppText(state.share.item.title(), size: title, weight: ft7),
        //
        if (!state.editor.editorState.document.isEmpty) AppEditor(maxWidth: 300, placeholder: ''),
        //
      ],
    ).animate().fadeIn();
  }
}
