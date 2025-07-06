import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/sync/delete_item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_state/_providers.dart';
import '../../../_state/focus.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../reminders/edit_menu.dart';
import '../../tags/menu.dart';
import '../state/selection.dart';
import '../w/emoji_menu.dart';

class ItemActions extends StatelessWidget {
  const ItemActions({super.key, required this.doc, this.isPersistent = false});

  final Item doc;
  final bool isPersistent;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, FocusProvider>(builder: (context, selection, focus, child) {
      bool isNotSelection = selection.selected.isEmpty;
      bool isAlternate = state.views.isAlternateView();
      bool isHovered = focus.id == doc.id;
      bool show = isPersistent || (isHovered && isAlternate);

      return Visibility(
        visible: show,
        child: Planet(
          menu: Menu(
            width: 200,
            items: [
              //
              MenuItem(label: doc.title(), faded: true, sh: true, popTrailing: true),
              menuDivider(),
              // select doc
              if (!doc.isTrashed())
                MenuItem(
                  label: 'Select',
                  leading: selectionIcon,
                  onTap: () => selection.select(doc),
                ),
              // pin
              if (!doc.isTrashed())
                MenuItem(
                  label: doc.isPinned() ? 'Unpin' : 'Pin',
                  leading: pinIcon,
                  onTap: () => quickEdit(
                    action: doc.isPinned() ? 'd' : 'c',
                    parent: doc.parent,
                    id: doc.id,
                    key: itemPinned,
                    value: 1,
                  ),
                ),
              // tags
              if (!doc.isTrashed())
                MenuItem(
                  label: doc.hasTags() ? 'Edit Tags' : 'Add Tags',
                  leading: tagIcon,
                  menu: tagsMenu(
                    doc: doc,
                    title: doc.title(),
                    isSelection: true,
                    onUpdate: (newTags) async {
                      await quickEdit(
                        action: newTags.isEmpty ? 'd' : 'c',
                        parent: doc.parent,
                        id: doc.id,
                        key: itemTags,
                        value: newTags,
                      );
                    },
                  ),
                ),
              // reminder
              if (!doc.isTrashed())
                MenuItem(
                  label: doc.hasReminder() ? 'Edit Reminder' : 'Add Reminder',
                  leading: reminderIcon,
                  menu: reminderMenu(doc),
                ),
              // color
              if (!doc.isTrashed())
                MenuItem(
                  label: doc.hasColor() ? 'Edit Color' : 'Choose Color',
                  leading: colorIcon,
                  menu: colorMenu(
                    title: doc.title(),
                    selectedColor: doc.color(),
                    onSelect: (newColor) async {
                      await quickEdit(
                        action: newColor.isEmpty ? 'd' : 'c',
                        parent: doc.parent,
                        id: doc.id,
                        key: itemColor,
                        value: newColor,
                      );
                    },
                  ),
                ),
              // emoji
              if (!doc.isTrashed())
                MenuItem(
                  label: doc.hasEmoji() ? 'Edit Emoji' : 'Choose Emoji',
                  leading: emojiIcon,
                  menu: emojiMenu(
                    onSelect: (emoji) => quickEdit(parent: doc.parent, id: doc.id, key: itemEmoji, value: emoji),
                    onRemove: () => quickEdit(action: 'd', parent: doc.parent, id: doc.id, key: itemEmoji),
                  ),
                ),
              //
              if (!doc.isTrashed()) menuDivider(),
              // archive
              if (!doc.isTrashed())
                MenuItem(
                  label: doc.isArchived() ? 'Unarchive' : 'Archive',
                  leading: doc.isArchived() ? unarchiveIcon : archiveIcon,
                  onTap: () async {
                    await quickEdit(
                      action: doc.isArchived() ? 'd' : 'c',
                      parent: doc.parent,
                      id: doc.id,
                      key: itemArchived,
                      value: 1,
                    );
                  },
                ),
              // trash
              if (!doc.isTrashed())
                MenuItem(
                  label: 'Move To Trash',
                  leading: deleteIcon,
                  onTap: () async {
                    await quickEdit(parent: doc.parent, id: doc.id, key: itemTrashed, value: 1);
                  },
                ),
              // restore
              if (doc.isTrashed() && isNotSelection)
                MenuItem(
                  label: 'Restore From Trash',
                  leading: restoreIcon,
                  color: Colors.green,
                  onTap: () async {
                    await quickEdit(action: 'd', parent: doc.parent, id: doc.id, key: itemTrashed);
                  },
                ),
              //
              if (!doc.isTrashed() && kDebugMode) menuDivider(),
              //
              if (doc.isTrashed() || kDebugMode)
                MenuItem(
                  label: 'Delete Forever',
                  leading: deleteForeverIcon,
                  color: Colors.red,
                  onTap: () async {
                    await showConfirmationDialog(
                      title: 'Delete <b>${doc.title()}</b> forever?',
                      content: 'You will not be able to recover the doc.',
                      yeslabel: 'Delete',
                      onAccept: () async => await deleteItemForever(doc),
                    );
                  },
                ),
              //
            ],
          ),
          noStyling: true,
          isSquare: true,
          padding: padT(),
          child: Center(child: AppIcon(moreIcon, size: extra, extraFaded: true)),
        ),
      );
    });
  }
}
