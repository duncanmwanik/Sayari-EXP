import 'package:flutter/material.dart';
import '../../editor_state.dart';

typedef ShortcutEventHandler = KeyEventResult Function(
  EditorState editorState,
  KeyEvent? event,
);
