import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/editor/appflowy/appflowy_editor.dart';
import '../../../_widgets/editor/editor.dart';
import '../../../_widgets/files/file_list.dart';
import '../../../_widgets/others/divider_vertical.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import 'actions.dart';

class IncomingMessageBubble extends StatefulWidget {
  const IncomingMessageBubble({super.key, required this.message});
  final Item message;

  @override
  State<IncomingMessageBubble> createState() => _IncomingMessageBubbleState();
}

class _IncomingMessageBubbleState extends State<IncomingMessageBubble> {
  bool showMore = false;
  EditorState editorState = EditorState.blank();

  @override
  void initState() {
    editorState = EditorState(document: Document.fromJson(jsonDecode(widget.message.content())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message = widget.message.content();
    bool isLong = message.length > 1000;

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MouseRegion(
        onEnter: (value) => state.focus.set(widget.message.sid),
        onExit: (value) => state.focus.reset(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user dp
            Align(
              alignment: Alignment.topLeft,
              child: Planet(
                width: 28,
                height: 28,
                showBorder: true,
                padding: noPadding,
                radius: borderRadiusLarge,
                color: Color.alphaBlend(styler.appColor(3), widget.message.email().toColor()),
                child: Center(child: AppText(widget.message.email()[0].cap())),
              ),
            ),
            spw(),
            // message
            Flexible(
              child: Planet(
                radius: 25,
                dryWidth: true,
                noStyling: true,
                blurred: isImage(),
                padding: padC('l3,r8,t3'),
                maxWidth: constraints.maxWidth * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Row(
                      children: [
                        // email
                        Flexible(
                          child: Planet(
                            onPressed: () {},
                            noStyling: true,
                            padding: padT('l'),
                            hoverColor: transparent,
                            child: AppText(widget.message.email(), size: tiny, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        AppSeparator(padding: padM()),
                        // pinned
                        if (widget.message.isPinned()) AppIcon(Icons.push_pin, size: tiny, rotation: 30, faded: true, padding: padM('r')),
                        // time
                        Flexible(child: AppText(size: tiny, getMessageTime(widget.message.sid), faded: true, weight: FontWeight.w500)),
                        //
                      ],
                    ),
                    tph(),
                    // files
                    if (widget.message.hasFiles()) FileList(item: widget.message),
                    if (widget.message.hasFiles()) mph(),
                    // message
                    AppEditor(
                      editorState: editorState,
                      editable: false,
                      scale: 0.9,
                      margin: padC('l6,r6'),
                      maxHeight: showMore ? null : 500,
                    ),
                    // read more
                    if (isLong)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Planet(
                          onPressed: () => setState(() => showMore = !showMore),
                          noStyling: true,
                          svp: true,
                          padding: padC(showMore ? 'l8,r8,t4,b4' : 'l8,r8,b4'),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!showMore) AppText('...', size: small),
                              AppText(showMore ? 'Show less' : 'Read more', size: small, color: Colors.blue),
                            ],
                          ),
                        ),
                      ),
                    //
                  ],
                ),
              ),
            ),
            // options
            tpw(),
            MessageActions(message: widget.message),
            //
          ],
        ),
      );
    });
  }
}
