import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../_theme/variables.dart';
import '../../appflowy_editor.dart';

typedef SelectionMenuItemHandler = void Function(
  EditorState editorState,
  SelectionMenuService menuService,
  BuildContext context,
);

typedef SelectionMenuItemNameBuilder = Widget Function(
  String name,
  SelectionMenuStyle style,
  bool isSelected,
);

/// Selection Menu Item
class SelectionMenuItem {
  SelectionMenuItem({
    required String Function() getName,
    required this.icon,
    required this.keywords,
    required SelectionMenuItemHandler handler,
    this.nameBuilder,
    this.deleteKeywords = false,
    this.deleteSlash = true,
  }) : _getName = getName {
    this.handler = (editorState, menuService, context) {
      if (deleteSlash || deleteKeywords) {
        _deleteSlash(editorState);
      }

      handler(editorState, menuService, context);
      onSelected?.call();
    };
  }

  final String Function() _getName;
  final Widget Function(
    EditorState editorState,
    bool onSelected,
    SelectionMenuStyle style,
  ) icon;
  final SelectionMenuItemNameBuilder? nameBuilder;

  String get name => _getName();

  /// Customizes keywords for item.
  ///
  /// The keywords are used to quickly retrieve items.
  final List<String> keywords;
  List<String> get allKeywords => keywords + [name.toLowerCase()];
  late final SelectionMenuItemHandler handler;

  VoidCallback? onSelected;

  bool deleteSlash;
  bool deleteKeywords;

  void _deleteSlash(EditorState editorState) {
    final selection = editorState.selection;
    if (selection == null || !selection.isCollapsed) {
      return;
    }
    final node = editorState.getNodeAtPath(selection.end.path);
    final delta = node?.delta;
    if (node == null || delta == null) {
      return;
    }
    final end = selection.start.offset;
    int deletedIndex = 0;

    if (deleteKeywords) {
      deletedIndex = 0;
    } else if (deleteSlash) {
      deletedIndex = delta.toPlainText().substring(0, end).lastIndexOf('/');
    }

    // delete all the texts after '/' along with '/'
    final transaction = editorState.transaction
      ..deleteText(
        node,
        deletedIndex,
        end - deletedIndex,
      );

    editorState.apply(transaction);
  }

  /// Creates a selection menu entry for inserting a [Node].
  /// [getName] and [iconData] define the appearance within the selection menu.
  ///
  /// The insert position is determined by the result of [replace] and
  /// [insertBefore]
  /// If no values are provided for [replace] and [insertBefore] the node is
  /// inserted after the current selection.
  /// [replace] takes precedence over [insertBefore]
  ///
  /// [updateSelection] can be used to update the selection after the node
  /// has been inserted.
  factory SelectionMenuItem.node({
    required String Function() getName,
    required List<String> keywords,
    required Node Function(EditorState editorState, BuildContext context) nodeBuilder,
    IconData? iconData,
    Widget Function(
      EditorState editorState,
      bool onSelected,
      SelectionMenuStyle style,
    )? iconBuilder,
    SelectionMenuItemNameBuilder? nameBuilder,
    bool Function(EditorState editorState, Node node)? insertBefore,
    bool Function(EditorState editorState, Node node)? replace,
    Selection? Function(
      EditorState editorState,
      Path insertPath,
      bool replaced,
      bool insertedBefore,
    )? updateSelection,
  }) {
    // the iconData and iconBuilder are mutually exclusive
    assert(iconData == null || iconBuilder == null);
    assert(iconData != null || iconBuilder != null);

    return SelectionMenuItem(
      getName: getName,
      nameBuilder: nameBuilder,
      icon: (editorState, onSelected, style) {
        if (iconData != null) {
          return Icon(
            iconData,
            color: onSelected ? style.selectionMenuItemSelectedIconColor : style.selectionMenuItemIconColor,
            size: 18.0,
          );
        } else if (iconBuilder != null) {
          return iconBuilder.call(editorState, onSelected, style);
        }

        return const SizedBox.shrink();
      },
      keywords: keywords,
      handler: (editorState, _, context) {
        final selection = editorState.selection;
        if (selection == null || !selection.isCollapsed) {
          return;
        }
        final node = editorState.getNodeAtPath(selection.end.path);
        final delta = node?.delta;
        if (node == null || delta == null) {
          return;
        }
        final newNode = nodeBuilder(editorState, context);
        final transaction = editorState.transaction;
        final bReplace = replace?.call(editorState, node) ?? false;
        final bInsertBefore = insertBefore?.call(editorState, node) ?? false;

        //default insert after
        var path = node.path.next;
        if (bReplace) {
          path = node.path;
        } else if (bInsertBefore) {
          path = node.path;
        }

        transaction
          ..insertNode(path, newNode)
          ..afterSelection = updateSelection?.call(
                editorState,
                path,
                bReplace,
                bInsertBefore,
              ) ??
              selection;

        if (bReplace) {
          transaction.deleteNode(node);
        }

        editorState.apply(transaction);
      },
    );
  }
}

class SelectionMenuStyle {
  const SelectionMenuStyle({
    required this.selectionMenuBackgroundColor,
    required this.selectionMenuItemTextColor,
    required this.selectionMenuItemIconColor,
    required this.selectionMenuItemSelectedTextColor,
    required this.selectionMenuItemSelectedIconColor,
    required this.selectionMenuItemSelectedColor,
  });

  static const light = SelectionMenuStyle(
    selectionMenuBackgroundColor: Color(0xFFFFFFFF),
    selectionMenuItemTextColor: Color(0xFF333333),
    selectionMenuItemIconColor: Color(0xFF333333),
    selectionMenuItemSelectedTextColor: Color.fromARGB(255, 56, 91, 247),
    selectionMenuItemSelectedIconColor: Color.fromARGB(255, 56, 91, 247),
    selectionMenuItemSelectedColor: Color(0xFFE0F8FF),
  );

  static const dark = SelectionMenuStyle(
    selectionMenuBackgroundColor: Color(0xFF282E3A),
    selectionMenuItemTextColor: Color(0xFFBBC3CD),
    selectionMenuItemIconColor: Color(0xFFBBC3CD),
    selectionMenuItemSelectedTextColor: Color(0xFF131720),
    selectionMenuItemSelectedIconColor: Color(0xFF131720),
    selectionMenuItemSelectedColor: Color(0xFF00BCF0),
  );

  final Color selectionMenuBackgroundColor;
  final Color selectionMenuItemTextColor;
  final Color selectionMenuItemIconColor;
  final Color selectionMenuItemSelectedTextColor;
  final Color selectionMenuItemSelectedIconColor;
  final Color selectionMenuItemSelectedColor;
}

class SelectionMenuWidget extends StatefulWidget {
  const SelectionMenuWidget({
    super.key,
    required this.items,
    required this.maxItemInRow,
    required this.editorState,
    required this.menuService,
    required this.onExit,
    required this.onSelectionUpdate,
    required this.selectionMenuStyle,
    required this.itemCountFilter,
    required this.deleteSlashByDefault,
    this.singleColumn = false,
    this.nameBuilder,
  });

  final List<SelectionMenuItem> items;
  final int itemCountFilter;
  final int maxItemInRow;

  final SelectionMenuService menuService;
  final EditorState editorState;

  final VoidCallback onSelectionUpdate;
  final VoidCallback onExit;

  final SelectionMenuStyle selectionMenuStyle;

  final bool deleteSlashByDefault;
  final bool singleColumn;

  final SelectionMenuItemNameBuilder? nameBuilder;

  @override
  State<SelectionMenuWidget> createState() => _SelectionMenuWidgetState();
}

class _SelectionMenuWidgetState extends State<SelectionMenuWidget> {
  final _focusNode = FocusNode(debugLabel: 'popup_list_widget');

  int _selectedIndex = 0;
  List<SelectionMenuItem> _showingItems = [];
  AutoScrollController? _scrollController;

  int _searchCounter = 0;

  String _keyword = '';
  String get keyword => _keyword;
  set keyword(String newKeyword) {
    _keyword = newKeyword;

    // Search items according to the keyword, and calculate the length of
    //  the longest keyword, which is used to dismiss the selection_service.
    var maxKeywordLength = 0;
    final items = widget.items
        .where(
          (item) => item.allKeywords.any((keyword) {
            final value = keyword.contains(newKeyword.toLowerCase());
            if (value) {
              maxKeywordLength = max(maxKeywordLength, keyword.length);
            }
            return value;
          }),
        )
        .toList(growable: false);

    AppFlowyEditorLog.ui.debug('$items');

    if (keyword.length >= maxKeywordLength + 2 && !(widget.deleteSlashByDefault && _searchCounter < 2)) {
      return widget.onExit();
    }
    setState(() {
      _showingItems = items;
    });

    if (_showingItems.isEmpty) {
      _searchCounter++;
    } else {
      _searchCounter = 0;
    }
  }

  @override
  void initState() {
    super.initState();

    _showingItems = widget.items;
    if (widget.singleColumn) {
      _scrollController = AutoScrollController();
    }

    keepEditorFocusNotifier.increase();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    keepEditorFocusNotifier.decrease();
    _scrollController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _onKeyEvent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.selectionMenuStyle.selectionMenuBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: _showingItems.isEmpty
            ? _buildNoResultsWidget(context)
            : _buildResultsWidget(
                context,
                _showingItems,
                widget.itemCountFilter,
                _selectedIndex,
              ),
      ),
    );
  }

  void _scrollToSelectedIndex() {
    if (_scrollController == null) {
      return;
    }

    _scrollController?.scrollToIndex(
      _selectedIndex,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  Widget _buildResultsWidget(
    BuildContext buildContext,
    List<SelectionMenuItem> items,
    int itemCountFilter,
    int selectedIndex,
  ) {
    if (widget.singleColumn) {
      List<Widget> itemWidgets = [];
      for (var i = 0; i < items.length; i++) {
        itemWidgets.add(
          AutoScrollTag(
            key: ValueKey(i),
            index: i,
            controller: _scrollController!,
            child: SelectionMenuItemWidget(
              item: items[i],
              isSelected: selectedIndex == i,
              editorState: widget.editorState,
              menuService: widget.menuService,
              selectionMenuStyle: widget.selectionMenuStyle,
            ),
          ),
        );
      }
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300,
          minWidth: 300,
          maxWidth: 300,
        ),
        child: ListView(
          shrinkWrap: true,
          controller: _scrollController,
          children: itemWidgets,
        ),
      );
    } else {
      List<Widget> columns = [];
      List<Widget> itemWidgets = [];
      // apply item count filter
      if (itemCountFilter > 0) {
        items = items.take(itemCountFilter).toList();
      }

      for (var i = 0; i < items.length; i++) {
        if (i != 0 && i % (widget.maxItemInRow) == 0) {
          columns.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: itemWidgets,
            ),
          );
          itemWidgets = [];
        }
        itemWidgets.add(
          SelectionMenuItemWidget(
            item: items[i],
            isSelected: selectedIndex == i,
            editorState: widget.editorState,
            menuService: widget.menuService,
            selectionMenuStyle: widget.selectionMenuStyle,
          ),
        );
      }
      if (itemWidgets.isNotEmpty) {
        columns.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemWidgets,
          ),
        );
        itemWidgets = [];
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns,
      );
    }
  }

  Widget _buildNoResultsWidget(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 140,
        child: Material(
          child: Text(
            'No results',
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// Handles arrow keys to switch selected items
  /// Handles keyword searches
  /// Handles enter to select item and esc to exit
  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    AppFlowyEditorLog.keyboard.debug('slash command, on key $event');

    if (event is KeyRepeatEvent) {
      return KeyEventResult.skipRemainingHandlers;
    }

    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final arrowKeys = [
      LogicalKeyboardKey.arrowLeft,
      LogicalKeyboardKey.arrowRight,
      LogicalKeyboardKey.arrowUp,
      LogicalKeyboardKey.arrowDown,
    ];

    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (0 <= _selectedIndex && _selectedIndex < _showingItems.length) {
        _showingItems[_selectedIndex].handler(widget.editorState, widget.menuService, context);
        return KeyEventResult.handled;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      widget.onExit();
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_searchCounter > 0) {
        _searchCounter--;
      }
      if (keyword.isEmpty) {
        widget.onExit();
      } else {
        keyword = keyword.substring(0, keyword.length - 1);
      }
      _deleteLastCharacters();
      return KeyEventResult.handled;
    } else if (event.character != null && !arrowKeys.contains(event.logicalKey) && event.logicalKey != LogicalKeyboardKey.tab) {
      keyword += event.character!;
      _insertText(event.character!);
      return KeyEventResult.handled;
    }

    var newSelectedIndex = _selectedIndex;
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      // When going left, wrap to the end of the previous row
      newSelectedIndex -= widget.maxItemInRow;
      if (newSelectedIndex < 0) {
        // Calculate the last row's starting position
        final lastRowStart = (_showingItems.length - 1) - ((_showingItems.length - 1) % widget.maxItemInRow);
        // Move to the same column in the last row
        newSelectedIndex = lastRowStart + (_selectedIndex % widget.maxItemInRow);
        if (newSelectedIndex >= _showingItems.length) {
          newSelectedIndex = _showingItems.length - 1;
        }
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      // When going right, wrap to the start of the next row
      newSelectedIndex += widget.maxItemInRow;
      if (newSelectedIndex >= _showingItems.length) {
        newSelectedIndex = _selectedIndex % widget.maxItemInRow;
        if (newSelectedIndex >= _showingItems.length) {
          newSelectedIndex = _showingItems.length - 1;
        }
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (newSelectedIndex > 0) {
        newSelectedIndex -= 1;
      } else {
        // Wrap to the last item
        newSelectedIndex = _showingItems.length - 1;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (newSelectedIndex < _showingItems.length - 1) {
        newSelectedIndex += 1;
      } else {
        // Wrap to the first item
        newSelectedIndex = 0;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.tab) {
      newSelectedIndex += 1;
      if (newSelectedIndex >= _showingItems.length) {
        newSelectedIndex = 0;
      }
    }

    if (newSelectedIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newSelectedIndex.clamp(0, _showingItems.length - 1);
        _scrollToSelectedIndex();
      });
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _deleteLastCharacters({int length = 1}) {
    final selection = widget.editorState.selection;
    if (selection == null || !selection.isCollapsed) {
      return;
    }
    final node = widget.editorState.getNodeAtPath(selection.end.path);
    final delta = node?.delta;
    if (node == null || delta == null) {
      return;
    }

    widget.onSelectionUpdate();
    final transaction = widget.editorState.transaction
      ..deleteText(
        node,
        selection.start.offset - length,
        length,
      );
    widget.editorState.apply(transaction);
  }

  void _insertText(String text) {
    final selection = widget.editorState.selection;
    if (selection == null || !selection.isSingle) {
      return;
    }
    final node = widget.editorState.getNodeAtPath(selection.end.path);
    if (node == null) {
      return;
    }
    widget.onSelectionUpdate();
    final transaction = widget.editorState.transaction;
    transaction.insertText(
      node,
      selection.end.offset,
      text,
    );
    widget.editorState.apply(transaction);
  }
}
