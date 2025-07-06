import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_services/hive/boxes.dart';
import '../../_state/_providers.dart';
import '../../_state/input.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/editor/editor.dart';
import '../../_widgets/files/_helpers/get_files.dart';
import '../../_widgets/files/file_list.dart';
import '../../_widgets/others/icons.dart';
import '../ai/ai_sheet.dart';
import 'w/scroll_btn.dart';
import 'w/send_btn.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    state.editor.reset(blocks: globalBox.get(chatBlocks), savePath: chatBlocks);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          ScrollChatsButton(),
          //
          Planet(
            margin: isSmallPC() ? padC('l8,r8,b16') : padM(),
            padding: padM(),
            maxHeight: 40.h,
            maxWidth: webMaxWidth,
            radius: borderRadiusMedium,
            color: Color.alphaBlend(styler.appColor(1), styler.primaryColor()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Consumer<InputProvider>(
                          builder: (context, input, child) => Visibility(
                            visible: input.item.hasFiles(),
                            child: Padding(
                              padding: padC('l8,r8,t4,b16'),
                              child: FileList(item: input.item),
                            ),
                          ),
                        ),
                        //
                        AppEditor(margin: padM('lrb'), maxHeight: 300),
                        //
                      ],
                    ),
                  ),
                ),
                //
                Row(
                  spacing: sw(),
                  children: [
                    // attach files
                    Planet(
                      onPressed: () => getFilesToUpload(),
                      tooltip: 'Attach File',
                      isRound: true,
                      padding: padM(),
                      radius: borderRadiusMedium - 6,
                      child: AppIcon(Icons.add, faded: true),
                    ),
                    //
                    Planet(
                      onPressed: () => showAISheet(),
                      tooltip: 'Chat with AI',
                      isRound: true,
                      padding: padM(),
                      radius: borderRadiusMedium - 6,
                      child: AppIcon(Icons.mic, faded: true),
                    ),
                    //
                    Spacer(),
                    //
                    SendMessageButton(),
                    //
                  ],
                ),
                //
              ],
            ),
          ),
          //
        ],
      ),
    );
  }
}
