import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';

/// cut.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent cutCommand = CommandShortcutEvent(
  key: 'cut the selected content',
  getDescription: () => AppFlowyEditorL10n.current.cmdCutSelection,
  command: 'ctrl+x',
  macOSCommand: 'cmd+x',
  handler: _cutCommandHandler,
);

CommandShortcutEventHandler _cutCommandHandler = (editorState) {
  if (editorState.selection == null) {
    return KeyEventResult.ignored;
  }
  // plain text.
  handleCut(editorState);
  return KeyEventResult.handled;
};
