import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';

/// End key event.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent exitEditingCommand = CommandShortcutEvent(
  key: 'exit the editing mode',
  getDescription: () => AppFlowyEditorL10n.current.cmdExitEditing,
  command: 'escape',
  handler: _exitEditingCommandHandler,
);

CommandShortcutEventHandler _exitEditingCommandHandler = (editorState) {
  editorState.selection = null;
  editorState.service.keyboardService?.closeKeyboard();
  return KeyEventResult.handled;
};
