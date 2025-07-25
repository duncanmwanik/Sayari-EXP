import 'dart:math';

import 'package:flutter/foundation.dart';
import '../../appflowy_editor.dart';

typedef Path = List<int>;

extension PathExtensions on Path {
  bool equals(Path other) {
    return listEquals(this, other);
  }

  bool operator >=(Path other) {
    if (equals(other)) {
      return true;
    }
    return this > other;
  }

  bool operator >(Path other) {
    if (equals(other)) {
      return false;
    }
    final length = min(this.length, other.length);
    for (var i = 0; i < length; i++) {
      if (this[i] < other[i]) {
        return false;
      } else if (this[i] > other[i]) {
        return true;
      }
    }
    if (this.length < other.length) {
      return false;
    }
    return true;
  }

  bool operator <=(Path other) {
    if (equals(other)) {
      return true;
    }
    return this < other;
  }

  bool operator <(Path other) {
    if (equals(other)) {
      return false;
    }
    final length = min(this.length, other.length);
    for (var i = 0; i < length; i++) {
      if (this[i] > other[i]) {
        return false;
      } else if (this[i] < other[i]) {
        return true;
      }
    }
    if (this.length > other.length) {
      return false;
    }
    return true;
  }

  Path get next {
    Path nextPath = Path.from(this, growable: true);
    if (isEmpty) {
      return nextPath;
    }
    final last = nextPath.last;
    return nextPath
      ..removeLast()
      ..add(last + 1);
  }

  Path nextNPath(int n) {
    Path nextPath = Path.from(this, growable: true);
    if (isEmpty) {
      return nextPath;
    }
    final last = nextPath.last;
    return nextPath
      ..removeLast()
      ..add(last + n);
  }

  Path child(int index) {
    return Path.from(this, growable: true)..add(index);
  }

  Path get previous {
    Path previousPath = Path.from(this, growable: true);
    if (isEmpty) {
      return previousPath;
    }
    final last = previousPath.last;
    return previousPath
      ..removeLast()
      ..add(max(0, last - 1));
  }

  Path previousNPath(int n) {
    Path previousPath = Path.from(this, growable: true);
    if (isEmpty) {
      return previousPath;
    }
    final last = previousPath.last;
    return previousPath
      ..removeLast()
      ..add(max(0, last - n));
  }

  Path get parent {
    if (isEmpty) {
      return this;
    }
    return Path.from(this, growable: true)..removeLast();
  }

  bool isAncestorOf(Path other) {
    if (isEmpty) {
      return true;
    }
    if (other.isEmpty) {
      return false;
    }
    if (length >= other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }

  // if isSameDepth is true, the path must be the same depth as the selection
  bool inSelection(
    Selection? selection, {
    bool isSameDepth = false,
  }) {
    selection = selection?.normalized;
    bool result = selection != null && selection.start.path <= this && this <= selection.end.path;
    if (isSameDepth) {
      return result && selection.start.path.length == length;
    }
    return result;
  }
}
