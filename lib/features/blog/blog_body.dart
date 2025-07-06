import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/editor/editor.dart';
import '../../_widgets/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../share/w_shared/header.dart';
import 'blog_info.dart';

class BlogBody extends StatelessWidget {
  const BlogBody({super.key});

  @override
  Widget build(BuildContext context) {
    state.editor.reset(blocks: state.share.item.content());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        SharedHeader(showDivider: false),
        //
        Expanded(
          child: NoScrollBars(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: webSuperMaxWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Padding(
                      padding: padN('lr'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          AppText(state.share.item.title(), size: 28, weight: FontWeight.bold),
                          mph(),
                          BlogInfo(),
                          mph(),
                          AppEditor(editable: false),
                          //
                        ],
                      ),
                    ),
                    //
                    lpph(),
                    //
                  ],
                ),
              ),
            ),
          ),
        )
        //
      ],
    );
  }
}
