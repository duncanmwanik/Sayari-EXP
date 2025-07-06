import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/text.dart';
import '../../_helpers/common/global.dart';
import '../../_services/cloud/sync/quick_edit.dart';
import '../../_state/_providers.dart';
import '../../_theme/colors.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/other.dart';
import 'menu.dart';
import 'var/tag_model.dart';

class TagList extends StatelessWidget {
  const TagList({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    List tagList = splitList(item.tags());

    onUpdate(newTags) {
      if (item.isInput) {
        newTags.isEmpty ? state.input.remove('l') : state.input.update('l', newTags);
      } else {
        quickEdit(
          action: tagList.isEmpty ? 'd' : 'c',
          parent: features.docs,
          id: item.id,
          key: 'l',
          value: newTags,
        );
      }
    }

    Future<void> removeTag(String tagId) async {
      await Future.delayed(Duration.zero);
      tagList.remove(tagId);
      onUpdate(joinList(tagList));
    }

    return Padding(
      padding: padS('t'),
      child: Row(
        children: [
          // //
          // AppIcon(tagIcon, size: small, faded: true),
          // tspw(),
          //
          Flexible(
            child: Wrap(
                spacing: tw(),
                runSpacing: tw(),
                children: List.generate(tagList.length, (index) {
                  return ValueListenableBuilder(
                    valueListenable: local(features.tags).listenable(keys: [tagList[index]]),
                    builder: (context, box, child) {
                      Tag tag = Tag(id: tagList[index]);
                      Color color = tag.hasColor() ? backgroundColors[tag.color()]!.color : styler.appColor(0.5);

                      // good tag
                      if (local(features.tags).containsKey(tag.id)) {
                        return Planet(
                          menu: tagsMenu(doc: item, isSelection: true, onUpdate: onUpdate),
                          padding: padC('l5,r5,t1,b1'),
                          color: color.withOpacity(0.1),
                          maxWidth: item.isInput ? null : 100,
                          tooltip: tag.name(),
                          child: AppText(
                            tag.name(),
                            size: tinySmall,
                            color: tag.hasColor() ? color : null,
                            faded: true,
                            maxlines: item.isInput ? null : 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }
                      // if tag is missing
                      else {
                        removeTag(tag.id);
                        return NoWidget();
                      }
                    },
                  );
                })),
          ),
          //
        ],
      ),
    );
  }
}
