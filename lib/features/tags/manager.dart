import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_helpers/common/global.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/others/text.dart';
import 'new_tag.dart';
import 'tag.dart';
import 'var/tag_model.dart';

class TagManager extends StatefulWidget {
  const TagManager({
    super.key,
    this.item,
    this.isPopup = false,
    this.isSelection = false,
    this.onUpdate,
  });

  final Item? item;
  final bool isPopup;
  final bool isSelection;
  final Function(String)? onUpdate;

  @override
  State<TagManager> createState() => _TagManagerState();
}

class _TagManagerState extends State<TagManager> {
  List selectedTags = [];

  @override
  void initState() {
    if (widget.item != null) selectedTags = splitList(widget.item!.tags());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local(features.tags).listenable(),
        builder: (context, box, wgt) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //
              NewTag(),
              // defaults
              if (!widget.isSelection)
                TagItem(
                  tag: Tag(id: 'All'),
                  iconData: Icons.tag_rounded,
                  isPopup: widget.isPopup,
                  isDefault: true,
                ),
              if (!widget.isSelection)
                TagItem(
                  tag: Tag(id: 'Archive'),
                  iconData: Icons.archive_outlined,
                  isPopup: widget.isPopup,
                  isDefault: true,
                ),
              if (!widget.isSelection)
                TagItem(
                  tag: Tag(id: 'Trash'),
                  iconData: Icons.delete_outline,
                  isPopup: widget.isPopup,
                  isDefault: true,
                ),
              // user tags
              for (String tagId in box.keys.toList())
                TagItem(
                  tag: Tag(id: tagId),
                  isSelection: widget.isSelection,
                  isSelected: selectedTags.contains(tagId),
                  onSelect: () => setState(() => selectedTags.contains(tagId) ? selectedTags.remove(tagId) : selectedTags.add(tagId)),
                  isPopup: widget.isPopup,
                ),
              // no user tags
              if (box.isEmpty && widget.isSelection) Padding(padding: pad(p: 15), child: AppText('No tags yet', size: tiny, faded: true)),
              //
              if (box.isNotEmpty) mph(),
              //
              //
              if (box.isNotEmpty && widget.isSelection) sph(),
              if (box.isNotEmpty && widget.isSelection)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(isCancel: true),
                    ActionButton(label: 'Save', onPressed: () => popWhatsOnTop(todoLast: () => widget.onUpdate!(joinList(selectedTags)))),
                  ],
                ),
              //
            ],
          );
        });
  }
}
