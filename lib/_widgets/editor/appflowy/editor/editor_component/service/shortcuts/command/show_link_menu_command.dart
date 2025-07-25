import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';
import '../../../../util/platform_extension.dart';

/// Cmd / Ctrl + K: show link menu
/// - support
///   - desktop
///   - web
final CommandShortcutEvent showLinkMenuCommand = CommandShortcutEvent(
  key: 'link menu',
  getDescription: () => AppFlowyEditorL10n.current.cmdConvertToLink,
  command: 'ctrl+k',
  macOSCommand: 'cmd+k',
  handler: _showLinkMenu,
);

KeyEventResult _showLinkMenu(
  EditorState editorState,
) {
  if (PlatformExtension.isMobile) {
    assert(false, 'showLinkMenuCommand is not supported on mobile platform.');
    return KeyEventResult.ignored;
  }

  final selection = editorState.selection;
  if (selection == null || selection.isCollapsed) {
    return KeyEventResult.ignored;
  }
  final context = editorState.getNodeAtPath(selection.end.path)?.key.currentContext;
  if (context == null) {
    return KeyEventResult.ignored;
  }
  final nodes = editorState.getNodesInSelection(selection);
  final isHref = nodes.allSatisfyInSelection(selection, (delta) {
    return delta.everyAttributes(
      (attributes) => attributes[BuiltInAttributeKey.href] != null,
    );
  });

  showLinkMenu(
    context,
    editorState,
    selection,
    isHref,
  );

  return KeyEventResult.handled;
}
