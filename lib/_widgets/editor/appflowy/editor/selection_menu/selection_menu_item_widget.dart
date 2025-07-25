import 'package:flutter/material.dart';

import '../../../../../_theme/variables.dart';
import '../../editor_state.dart';
import 'selection_menu_service.dart';
import 'selection_menu_widget.dart';

class SelectionMenuItemWidget extends StatefulWidget {
  const SelectionMenuItemWidget({
    super.key,
    required this.editorState,
    required this.menuService,
    required this.item,
    required this.isSelected,
    required this.selectionMenuStyle,
    this.width = 140.0,
  });

  final EditorState editorState;
  final SelectionMenuService menuService;
  final SelectionMenuItem item;
  final double width;
  final bool isSelected;
  final SelectionMenuStyle selectionMenuStyle;

  @override
  State<SelectionMenuItemWidget> createState() => _SelectionMenuItemWidgetState();
}

class _SelectionMenuItemWidgetState extends State<SelectionMenuItemWidget> {
  var _onHover = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.selectionMenuStyle;
    final isSelected = widget.isSelected || _onHover;
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
      child: SizedBox(
        width: widget.width,
        child: TextButton.icon(
          icon: widget.item.icon(
            widget.editorState,
            widget.isSelected || _onHover,
            widget.selectionMenuStyle,
          ),
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              overlayColor: WidgetStateProperty.all(
                style.selectionMenuItemSelectedColor,
              ),
              backgroundColor: widget.isSelected
                  ? WidgetStateProperty.all(
                      style.selectionMenuItemSelectedColor,
                    )
                  : WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)))),
          label: widget.item.nameBuilder?.call(widget.item.name, style, isSelected) ??
              Text(
                widget.item.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: (widget.isSelected || _onHover) ? style.selectionMenuItemSelectedTextColor : style.selectionMenuItemTextColor,
                  fontSize: 12.0,
                ),
              ),
          onPressed: () {
            widget.item.handler(
              widget.editorState,
              widget.menuService,
              context,
            );
          },
          onHover: (value) {
            setState(() {
              _onHover = value;
            });
          },
        ),
      ),
    );
  }
}
