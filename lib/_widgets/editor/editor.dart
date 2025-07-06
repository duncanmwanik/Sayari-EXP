import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_services/hive/boxes.dart';
import '../../_state/_providers.dart';
import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import 'appflowy/appflowy_editor.dart';
import 'builders.dart';
import 'options.dart';
import 'styles.dart';

class AppEditor extends StatelessWidget {
  const AppEditor({
    super.key,
    this.json,
    this.editorState,
    this.scale = 1,
    this.maxWidth,
    this.maxHeight,
    this.minHeight,
    this.fontSize,
    this.margin,
    this.placeholder,
    this.editable = true,
    this.autoFocus = false,
    this.faded = false,
  });

  final String? json;
  final EditorState? editorState;
  final double scale;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final double? fontSize;
  final EdgeInsets? margin;
  final String? placeholder;
  final bool editable;
  final bool autoFocus;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    bool hasJson = json != null && json!.isNotEmpty;

    return ValueListenableBuilder(
      valueListenable: globalBox.listenable(keys: [editorStateRebuild]),
      builder: (context, value, child) {
        return IgnorePointer(
          ignoring: !editable,
          child: IntrinsicHeight(
            child: Container(
              margin: margin,
              constraints: constrain(minHeight: minHeight, maxHeight: maxHeight, maxWidth: maxWidth),
              child: FloatingToolbar(
                style: FloatingToolbarStyle(
                  backgroundColor: transparent,
                  toolbarIconColor: styler.textColor(mildFaded: true),
                  toolbarActiveColor: styler.accent(),
                ),
                items: [
                  paragraphItem,
                  ...headingItems,
                  ...markdownFormatItems,
                  quoteItem,
                  bulletedListItem,
                  numberedListItem,
                  linkItem,
                  buildTextColorItem(),
                  buildHighlightColorItem(),
                  // ...textDirectionItems,
                  ...alignmentItems,
                ],
                editorState: editorState ?? state.editor.editorState,
                editorScrollController: state.editor.scrollController(),
                textDirection: TextDirection.ltr,
                child: AppFlowyEditor(
                  editable: editable,
                  autoFocus: autoFocus,
                  shrinkWrap: true,
                  editorState:
                      hasJson ? EditorState(document: Document.fromJson(jsonDecode(json!))) : (editorState ?? state.editor.editorState),
                  editorStyle: customEditorStyle(scale: scale, faded: faded),
                  blockComponentBuilders: customComponentBuilder(scale: scale),
                  contextMenuItems: customContextMenuItems(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


//  MobileToolbarWidget(
//           editorState: EditorState(document: Document.fromJson(jsonDecode(json!))),
//           toolbarItems: [
//             MobileToolbarItem.action(
//               itemIconBuilder: (context, editorState, service) {
//                 return AppIcon(Icons.sunny, color: red);
//               },
//               actionHandler: (context, editorState) {},
//             )
//           ],
//           selection: Selection(start: Position(path: []), end: Position(path: [])),
//         ),