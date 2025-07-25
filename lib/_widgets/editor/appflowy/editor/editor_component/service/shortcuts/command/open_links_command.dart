import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';

/// Option/Alt + Shift + Enter: to open links
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent openLinksCommand = CommandShortcutEvent(
  key: 'open links',
  getDescription: () => AppFlowyEditorL10n.current.cmdOpenLinks,
  command: 'alt+shift+enter',
  handler: _openLinksHandler,
);

KeyEventResult _openLinksHandler(
  EditorState editorState,
) {
  final selection = editorState.selection;
  if (selection == null || selection.isCollapsed) {
    return KeyEventResult.ignored;
  }

  final nodes = editorState.getNodesInSelection(selection);

  // A set to store the links which should be opened
  final links = nodes
      .map((node) => node.delta)
      .nonNulls
      .expand(
        (node) => node.map<String?>(
          (op) => op.attributes?[AppFlowyRichTextKeys.href],
        ),
      )
      .nonNulls
      .toSet();

  for (final link in links) {
    safeLaunchUrl(link);
  }

  return KeyEventResult.handled;
}
