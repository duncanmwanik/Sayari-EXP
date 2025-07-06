import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/editor/appflowy/appflowy_editor.dart';
import '../../../_widgets/editor/editor.dart';
import '../../../_widgets/files/file_list.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import 'actions.dart';

class SentMessageBubble extends StatefulWidget {
  const SentMessageBubble({super.key, required this.message});
  final Item message;

  @override
  State<SentMessageBubble> createState() => _SentMessageBubbleState();
}

class _SentMessageBubbleState extends State<SentMessageBubble> {
  bool showMore = false;
  bool isEdit = false;
  EditorState editorState = EditorState.blank();

  @override
  void initState() {
    editorState = EditorState(document: Document.fromJson(jsonDecode(widget.message.content())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPending = pendingBox.containsKey(widget.message.sid);
    bool isLong = widget.message.content().length > 1000;

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth * 0.7;

      return MouseRegion(
        onEnter: (value) => state.focus.set(widget.message.sid),
        onExit: (value) => state.focus.reset(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // options
            MessageActions(message: widget.message, isSent: true),
            // message
            tpw(),
            Flexible(
              child: Planet(
                dryWidth: true,
                radius: 25,
                maxWidth: maxWidth,
                borderWidth: 0.3,
                minWidth: 200,
                color: styler.secondaryColor(),
                padding: padC('l12,r4,t8,b8'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // pinned
                        if (widget.message.isPinned()) AppIcon(Icons.push_pin, size: tiny, rotation: 30, faded: true, padding: padM('r')),
                        // time
                        AppText(size: tiny, getMessageTime(widget.message.sid), faded: true, weight: FontWeight.w500),
                        spw(),
                        // status
                        AppIcon(isPending ? Icons.refresh : Icons.done_all, size: small, faded: true),
                        spw(),
                        //
                      ],
                    ),
                    //
                  ],
                ),
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
