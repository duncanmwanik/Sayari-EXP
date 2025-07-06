import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_services/hive/boxes.dart';
import '../appflowy/appflowy_editor.dart';

class EditorProvider with ChangeNotifier {
  EditorState editorState = EditorState.blank();
  bool isChanged = false;
  bool isEmpty = false;

  EditorScrollController scrollController() {
    return EditorScrollController(editorState: editorState);
  }

  Future<void> reset({String? blocks, String? savePath}) async {
    editorState = EditorState.blank();
    isChanged = false;
    isEmpty = true;

    try {
      if (blocks != null && blocks.isNotEmpty) {
        editorState = EditorState(document: Document.fromJson(jsonDecode(blocks)));
      }
      listenToChanges(savePath);
    } catch (e) {
      logError('quillControllerReset', e);
    }

    isEmpty = editorState.document.isEmpty;
  }

  void listenToChanges(String? savePath) {
    // try {
    //   editorState.document.changes.listen((event) {
    //     isChanged = true;
    //     isEmpty = editorState.document.isEmpty;
    //     if (savePath != null) globalBox.put(savePath, getQuills());
    //     // show(controller.document.toPlainText());
    //     notifyListeners();
    //   });
    // } catch (e) {
    //   logError('quillControllerListening', e);
    // }
  }

  String getJson() => jsonEncode(editorState.document.toJson());
  String getText() => jsonEncode(editorState.document.toString());

  void clear([String? savePath]) {
    editorState = EditorState.blank();
    globalBox.delete(savePath);
  }
}
