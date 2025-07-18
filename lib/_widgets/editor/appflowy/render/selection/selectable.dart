import 'package:flutter/material.dart';
import '../../core/location/position.dart';
import '../../core/location/selection.dart';

enum CursorStyle {
  verticalLine,
  borderLine,
  cover,
}

/// [SelectableMixin] is used for the editor to calculate the position
///   and size of the selection.
///
/// The widget returned by NodeWidgetBuilder must be with [SelectableMixin],
///   otherwise the [AppFlowySelectionService] will not work properly.
mixin SelectableMixin<T extends StatefulWidget> on State<T> {
  /// Returns the [Rect] representing the block selection in current widget.
  ///
  /// Normally, the rect should not include the action menu area.
  Rect getBlockRect({
    bool shiftWithBaseOffset = false,
  });

  /// Returns the [Selection] surrounded by start and end
  ///   in current widget.
  ///
  /// [start] and [end] are the offsets under the global coordinate system.
  ///
  Selection getSelectionInRange(Offset start, Offset end);

  /// Returns a [List] of the [Rect] area within selection
  ///   in current widget.
  ///
  /// The return result must be a [List] of the [Rect]
  ///   under the local coordinate system.
  List<Rect> getRectsInSelection(
    Selection selection, {
    bool shiftWithBaseOffset = false,
  });

  /// Returns [Position] for the offset in current widget.
  ///
  /// [start] is the offset of the global coordination system.
  Position getPositionInOffset(Offset start);

  /// Returns [Rect] for the position in current widget.
  ///
  /// The return result must be an offset of the local coordinate system.
  Rect? getCursorRectInPosition(
    Position position, {
    bool shiftWithBaseOffset = false,
  }) {
    return null;
  }

  /// Return global offset from local offset.
  Offset localToGlobal(
    Offset offset, {
    bool shiftWithBaseOffset = false,
  });

  Position start();
  Position end();

  /// For [TextNode] only.
  ///
  /// Only the widget rendered by [TextNode] need to implement the detail,
  ///   and the rest can return null.
  TextSelection? getTextSelectionInSelection(Selection selection) => null;

  /// For [TextNode] only.
  ///
  /// Only the widget rendered by [TextNode] need to implement the detail,
  ///   and the rest can return null.
  Selection? getWordEdgeInOffset(Offset start) => null;

  /// For [TextNode] only.
  ///
  /// Only the widget rendered by [TextNode] need to implement the detail,
  ///   and the rest can return null.
  Selection? getWordBoundaryInOffset(Offset start) => null;

  /// For [TextNode] only.
  ///
  /// Only the widget rendered by [TextNode] need to implement the detail,
  ///   and the rest can return null.
  Selection? getWordBoundaryInPosition(Position position) => null;

  bool get shouldCursorBlink => true;

  CursorStyle get cursorStyle => CursorStyle.verticalLine;

  Rect transformRectToGlobal(
    Rect r, {
    bool shiftWithBaseOffset = false,
  }) {
    final topLeft = localToGlobal(
      r.topLeft,
      shiftWithBaseOffset: shiftWithBaseOffset,
    );
    return Rect.fromLTWH(topLeft.dx, topLeft.dy, r.width, r.height);
  }

  TextDirection textDirection() => TextDirection.ltr;
}
