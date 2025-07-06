import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/files/cover.dart';

class LinkItem extends StatelessWidget {
  const LinkItem({super.key, required this.index, required this.id});

  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    Item link = Item(id: id, data: state.input.item.data[id] ?? {});
    bool isTitle = link.typee() == itemLinkTypeTitle;

    return Planet(
      margin: padM('t'),
      padding: padS(),
      showBorder: true,
      noStyling: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Expanded(
            child: Form(
              child: Column(
                children: [
                  // title + image
                  DataInput(
                    parentKey: link.id,
                    hintText: 'Title',
                    weight: ft4,
                    notify: false,
                    color: styler.appColor(0.3),
                    textCapitalization: TextCapitalization.sentences,
                    contentPadding: padS(),
                    prefix: isTitle
                        ? AppIcon(Icons.title, extraFaded: true)
                        : Padding(
                            padding: padM('r'),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Cover(
                                parentKey: link.id,
                                size: 30,
                              ),
                            ),
                          ),
                  ),
                  // link
                  if (!isTitle)
                    DataInput(
                      inputKey: itemContent,
                      parentKey: link.id,
                      hintText: 'Link',
                      weight: ft4,
                      notify: false,
                      color: styler.appColor(0.3),
                      contentPadding: padS(),
                      margin: padT('t'),
                      prefix: AppIcon(Icons.link, padding: padM('r'), extraFaded: true),
                    ),
                  //
                ],
              ),
            ),
          ),
          // actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // delete
              Planet(
                menu: confirmationMenu(
                  title: 'Remove link: ${link.title()}',
                  yeslabel: 'Remove',
                  onAccept: () => state.input.remove(link.id),
                ),
                noStyling: true,
                isSquare: true,
                margin: padS('l'),
                child: AppIcon(Icons.close, size: extra, extraFaded: true),
              ),
              // reorder
              ReorderableDragStartListener(
                key: ValueKey(index),
                index: index,
                child: Planet(
                  noStyling: true,
                  isSquare: true,
                  margin: padS('l'),
                  child: AppIcon(Icons.drag_indicator, size: extra, extraFaded: true),
                ),
              ),
              //
            ],
          )
          //
        ],
      ),
    );
  }
}
