import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_state/_providers.dart';
import '../../_state/focus.dart';
import '../../_theme/colors.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helpers.dart';
import 'new_tag.dart';
import 'options.dart';
import 'var/tag_model.dart';

class TagItem extends StatefulWidget {
  const TagItem({
    super.key,
    required this.tag,
    this.isSelection = false,
    this.isSelected = false,
    this.onSelect,
    this.isPopup = false,
    this.isDefault = false,
    this.iconData,
  });

  final Tag tag;
  final bool isSelection;
  final bool isSelected;
  final Function()? onSelect;
  final bool isPopup;
  final bool isDefault;
  final IconData? iconData;

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool showOptions = (!widget.isDefault && !widget.isSelection && isHovered) || widget.isSelection;

    return Consumer<FocusProvider>(builder: (context, focus, child) {
      bool isEdit = focus.id == widget.tag.id;

      return isEdit
          ? NewTag(tag: widget.tag)
          : Planet(
              onPressed: widget.isSelection
                  ? widget.onSelect
                  : () {
                      if (state.views.tag != widget.tag.id) state.views.updateSelectedTag(widget.tag.id);
                      if (widget.isPopup) popWhatsOnTop();
                    },
              onHover: (value) => setState(() => isHovered = value),
              minHeight: 30,
              margin: padC('b1'),
              padding: widget.isSelection ? padC('l3,r1,t2,b2') : padC('l10,r1,t2,b2'),
              noStyling: !isSelectedTag(widget.tag.id) || widget.isSelection,
              child: Row(
                children: [
                  // selection
                  if (widget.isSelection)
                    AppCheckBox(
                      isChecked: widget.isSelected,
                      onTap: widget.onSelect,
                      margin: padS('r'),
                    ),
                  // color
                  AppIcon(
                    widget.iconData ?? (tagIcon),
                    color: widget.tag.hasColor() ? backgroundColors[widget.tag.color()]!.color : null,
                    mildFaded: true,
                    size: mediumNormal,
                  ),
                  // name
                  Expanded(
                    child: AppText(
                      widget.tag.name(),
                      mildFaded: true,
                      weight: isLight() ? FontWeight.w500 : null,
                      overflow: TextOverflow.ellipsis,
                      padding: padM('l'),
                    ),
                  ),
                  // options
                  Planet(
                    enabled: showOptions,
                    menu: tagOptionsMenu(widget.tag),
                    noStyling: true,
                    margin: padS('l'),
                    isSquare: true,
                    child: AppIcon(
                      moreIcon,
                      color: showOptions ? null : transparent,
                      extraFaded: true,
                      size: normal,
                    ),
                  ),
                  //
                ],
              ),
              //
            );
    });
  }
}
