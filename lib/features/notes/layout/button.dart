import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_state/views.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';

class LayoutButton extends StatelessWidget {
  const LayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Planet(
        menu: Menu(
          items: [
            //
            // MenuItem(label: 'View', labelSize: tiny, sh: true, popTrailing: true, faded: true),
            // MenuItem(
            //   label: docLayoutNormal.cap(),
            //   trailing: views.docLayout.isNormal() ? Icons.done : null,
            //   isSelected: views.docLayout.isNormal(),
            //   onTap: () => views.updateDocLayout(docLayoutNormal),
            // ),
            // MenuItem(
            //   label: docLayoutAlternate.cap(),
            //   trailing: views.docLayout.isAlternate() ? Icons.done : null,
            //   isSelected: views.docLayout.isAlternate(),
            //   onTap: () => views.updateDocLayout(docLayoutAlternate),
            // ),
            // //
            // if (views.docLayout.isNormal()) menuDivider(),
            // if (views.docLayout.isNormal()) MenuItem(label: 'Layout', labelSize: tiny, faded: true),
            MenuItem(label: 'Layout', labelSize: tiny, sh: true, popTrailing: true, faded: true),
            //
            if (views.docLayout.isNormal())
              Row(
                mainAxisAlignment: views.view.isKanban() ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
                children: [
                  Planet(
                    onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.docView, 'grid')),
                    isSquare: true,
                    noStyling: !views.isGrid(),
                    child: AppIcon(Icons.grid_view_outlined, color: views.isGrid() ? styler.accent() : null, faded: true),
                  ),
                  Planet(
                    onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.docView, 'row')),
                    isSquare: true,
                    noStyling: !views.isRow(),
                    child: AppIcon(Icons.view_agenda_outlined, color: views.isRow() ? styler.accent() : null, faded: true),
                  ),
                  Planet(
                    onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.docView, 'column')),
                    isSquare: true,
                    noStyling: !views.isColumn(),
                    child: AppIcon(Icons.view_agenda_outlined, color: views.isColumn() ? styler.accent() : null, rotation: 90, faded: true),
                  ),
                  Planet(
                    onPressed: () => popWhatsOnTop(todo: () => views.setLayout(views.docView, 'list')),
                    isSquare: true,
                    noStyling: !views.isList(),
                    child: AppIcon(Icons.format_list_bulleted_rounded, color: views.isList() ? styler.accent() : null, faded: true),
                  ),
                ],
              ),
            //
            tph(),
            menuDivider(),
            MenuItem(label: 'Sort By', labelSize: tiny, faded: true),
            //
            MenuItem(
              label: 'Newest',
              trailing: views.order.isNewest() ? Icons.done : null,
              isSelected: views.order.isNewest(),
              onTap: () => views.updateOrder(orderTypeNewest),
            ),
            MenuItem(
              label: 'Oldest',
              trailing: views.order.isOldest() ? Icons.done : null,
              isSelected: views.order.isOldest(),
              onTap: () => views.updateOrder(orderTypeOldest),
            ),
            MenuItem(
              label: 'Title A-Z',
              trailing: views.order.isTitleAZ() ? Icons.done : null,
              color: views.order.isTitleAZ() ? styler.accent() : null,
              onTap: () => views.updateOrder(orderTypeTitleAZ),
            ),
            MenuItem(
              label: 'Title Z-A',
              trailing: views.order.isTitleZA() ? Icons.done : null,
              isSelected: views.order.isTitleZA(),
              onTap: () => views.updateOrder(orderTypeTitleZA),
            ),
            //
          ],
        ),
        tooltip: 'View',
        noStyling: true,
        isSquare: true,
        child: AppIcon(
          views.isAlternateView()
              ? Icons.view_in_ar
              : views.isGrid()
                  ? Icons.grid_view_outlined
                  : views.isRow()
                      ? Icons.view_agenda_outlined
                      : views.isColumn()
                          ? Icons.view_agenda_outlined
                          : Icons.format_list_bulleted_rounded,
          size: normal,
          faded: true,
          rotation: views.isColumn() ? 90 : 0,
        ),
      );
    });
  }
}
