import 'package:flutter/material.dart';
import '../shortcut_event/shortcut_event_handler.dart';

ShortcutEventHandler redoEventHandler = (editorState, event) {
  editorState.undoManager.redo();
  return KeyEventResult.handled;
};

ShortcutEventHandler undoEventHandler = (editorState, event) {
  editorState.undoManager.undo();
  return KeyEventResult.handled;
};
