import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_services/cloud/sync/delete_item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../tags/menu.dart';
import '../state/selection.dart';
import 'selection_more.dart';

class SelectedItemOptions extends StatelessWidget {
  const SelectedItemOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.views.tag == 'Archive';
      bool isTrash = state.views.tag == 'Trash';

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          if (selection.selected.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // cancel
                Planet(
                  onPressed: () => state.selection.clear(),
                  noStyling: true,
                  isSquare: true,
                  tooltip: 'Cancel Selection',
                  child: AppIcon(closeIcon),
                ),
                spw(),
                //no of selected items
                AppText('${selection.selected.length} selected'),
                //
              ],
            ),
          //
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (!isTrash)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //
                    Planet(
                      onPressed: () {
                        selection.selected.forEach((item) async {
                          if (!item.isPinned()) await quickEdit(parent: item.parent, id: item.id, key: itemPinned, value: 1);
                        });
                        state.selection.clear();
                      },
                      noStyling: true,
                      isSquare: true,
                      tooltip: 'Pin',
                      child: AppIcon(pinIcon, faded: true),
                    ),
                    //
                    spw(),
                    //
                    Planet(
                      menu: tagsMenu(
                        isSelection: true,
                        onUpdate: (newTags) async {
                          selection.selected.forEach((item) async {
                            await quickEdit(parent: item.parent, id: item.id, key: itemTags, value: newTags);
                          });
                          state.selection.clear();
                        },
                      ),
                      noStyling: true,
                      isSquare: true,
                      tooltip: 'Tag',
                      child: AppIcon(tagIcon, faded: true),
                    ),
                    //
                    spw(),
                    //
                    Planet(
                      menu: colorMenu(
                        onSelect: (newColor) async {
                          selection.selected.forEach((item) async {
                            await quickEdit(parent: item.parent, id: item.id, key: itemColor, value: newColor);
                          });
                          state.selection.clear();
                        },
                      ),
                      noStyling: true,
                      isSquare: true,
                      tooltip: 'Color',
                      child: AppIcon(colorIcon, faded: true),
                    ),
                    //
                    if (isNotPhone()) spw(),
                    //
                    if (isNotPhone())
                      Planet(
                        onPressed: () {
                          if (isArchive) {
                            selection.selected.forEach((item) async {
                              await quickEdit(action: 'd', parent: item.parent, id: item.id, key: itemArchived);
                            });
                          } else {
                            selection.selected.forEach((item) async {
                              await quickEdit(parent: item.parent, id: item.id, key: itemArchived, value: 1);
                            });
                          }
                          state.selection.clear();
                        },
                        noStyling: true,
                        isSquare: true,
                        tooltip: isArchive ? 'Unarchive' : 'Archive',
                        child: AppIcon(isArchive ? unarchiveIcon : archiveIcon, faded: true),
                      ),
                    //
                    if (isNotPhone()) spw(),
                    //
                    if (isNotPhone())
                      Planet(
                        onPressed: () {
                          selection.selected.forEach((item) async {
                            await quickEdit(parent: item.parent, id: item.id, key: itemTrashed, value: 1);
                          });
                          state.selection.clear();
                        },
                        noStyling: true,
                        isSquare: true,
                        tooltip: 'Move To Trash',
                        child: AppIcon(deleteIcon, faded: true),
                      ),
                  ],
                ),
              //
              // trash actions --------------------------------- start
              //
              if (isTrash)
                Planet(
                  onPressed: () {
                    selection.selected.forEach((item) async {
                      await quickEdit(action: 'd', parent: item.parent, id: item.id, key: itemTrashed);
                    });
                    state.selection.clear();
                  },
                  noStyling: true,
                  isSquare: true,
                  tooltip: 'Restore From Trash',
                  child: AppIcon(restoreIcon, faded: true),
                ),
              //
              if (isTrash) spw(),
              //
              if (isTrash)
                Planet(
                  onPressed: () async {
                    await showConfirmationDialog(
                      title: 'Delete selected items forever?',
                      yeslabel: 'Delete',
                      onAccept: () async {
                        selection.selected.forEach((item) async {
                          await deleteItemForever(item);
                        });
                        state.selection.clear();
                      },
                    );
                  },
                  noStyling: true,
                  isSquare: true,
                  tooltip: 'Delete Forever',
                  child: AppIcon(deleteForeverIcon, faded: true),
                ),
              //
              // trash actions --------------------------------- end
              //
              // more actions --------------------------------- start
              // if screen is phone size
              //
              if (isPhone() && !isTrash) spw(),
              //
              if (isPhone() && !isTrash) ItemSelectionMore(),
              //
              // more actions --------------------------------- end
              //
              tpw(),
              //
            ],
          ),
          //
          //
          //
        ],
      );
    });
  }
}
