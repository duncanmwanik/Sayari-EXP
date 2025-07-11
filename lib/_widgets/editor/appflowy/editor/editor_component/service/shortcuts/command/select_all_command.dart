import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';

/// Select all key event.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent selectAllCommand = CommandShortcutEvent(
  key: 'select all the selectable content',
  getDescription: () => AppFlowyEditorL10n.current.cmdSelectAll,
  command: 'ctrl+a',
  macOSCommand: 'cmd+a',
  handler: _selectAllCommandHandler,
);

CommandShortcutEventHandler _selectAllCommandHandler = (editorState) {
  if (editorState.document.root.children.isEmpty || editorState.selection == null) {
    return KeyEventResult.ignored;
  }
  final lastSelectable = editorState.getLastSelectable();
  if (lastSelectable == null) {
    return KeyEventResult.handled;
  }
  final start = Position(path: [0]);
  final end = lastSelectable.$2.end(lastSelectable.$1);
  editorState.updateSelectionWithReason(
    Selection(start: start, end: end),
    reason: SelectionUpdateReason.selectAll,
  );
  return KeyEventResult.handled;
};
