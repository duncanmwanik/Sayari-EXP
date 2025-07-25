import 'dart:collection';

import '../appflowy_editor.dart';

/// A [HistoryItem] contains list of operations committed by users.
/// If a [HistoryItem] is not sealed, operations can be added sequentially.
/// Otherwise, the operations should be added to a new [HistoryItem].
final class HistoryItem extends LinkedListEntry<HistoryItem> {
  final List<Operation> operations = [];
  Selection? beforeSelection;
  Selection? afterSelection;
  bool _sealed = false;

  HistoryItem();

  /// Seal the history item.
  /// When an item is sealed, no more operations can be added
  /// to the item.
  ///
  /// The caller should create a new [HistoryItem].
  void seal() {
    _sealed = true;
  }

  bool get sealed => _sealed;

  void add(Operation op) {
    operations.add(op);
  }

  void addAll(Iterable<Operation> iterable) {
    operations.addAll(iterable);
  }

  /// Create a new [Transaction] by inverting the operations.
  Transaction toTransaction(EditorState state) {
    final builder = Transaction(document: state.document);
    for (var i = operations.length - 1; i >= 0; i--) {
      final operation = operations[i];
      final inverted = operation.invert();
      builder.add(inverted, transform: false);
    }
    builder.afterSelection = beforeSelection;
    builder.beforeSelection = afterSelection;
    return builder;
  }
}

class FixedSizeStack {
  final _list = LinkedList<HistoryItem>();
  final int maxSize;

  FixedSizeStack(this.maxSize);

  void push(HistoryItem stackItem) {
    if (_list.length >= maxSize) {
      _list.remove(_list.first);
    }
    _list.add(stackItem);
  }

  HistoryItem? pop() {
    if (_list.isEmpty) {
      return null;
    }
    final last = _list.last;

    _list.remove(last);

    return last;
  }

  void clear() {
    _list.clear();
  }

  HistoryItem get last => _list.last;

  bool get isEmpty => _list.isEmpty;

  bool get isNonEmpty => _list.isNotEmpty;
}

class UndoManager {
  final FixedSizeStack undoStack;
  final FixedSizeStack redoStack;
  EditorState? state;

  UndoManager([int stackSize = 20])
      : undoStack = FixedSizeStack(stackSize),
        redoStack = FixedSizeStack(stackSize);

  HistoryItem getUndoHistoryItem() {
    if (undoStack.isEmpty) {
      final item = HistoryItem();
      undoStack.push(item);
      return item;
    }
    final last = undoStack.last;
    if (last.sealed) {
      redoStack.clear();
      final item = HistoryItem();
      undoStack.push(item);
      return item;
    }
    return last;
  }

  void undo() {
    AppFlowyEditorLog.editor.debug('undo');
    final s = state;
    if (s == null) {
      return;
    }
    final historyItem = undoStack.pop();
    if (historyItem == null) {
      return;
    }
    final transaction = historyItem.toTransaction(s);
    s.apply(
      transaction,
      options: const ApplyOptions(
        recordUndo: false,
        recordRedo: true,
      ),
    );
  }

  void redo() {
    AppFlowyEditorLog.editor.debug('redo');
    final s = state;
    if (s == null) {
      return;
    }
    final historyItem = redoStack.pop();
    if (historyItem == null) {
      return;
    }
    final transaction = historyItem.toTransaction(s);
    s.apply(
      transaction,
      options: const ApplyOptions(
        recordUndo: true,
        recordRedo: false,
      ),
    );
  }

  void forgetRecentUndo() {
    AppFlowyEditorLog.editor.debug('forgetRecentUndo');
    if (state != null) {
      undoStack.pop();
    }
  }
}
