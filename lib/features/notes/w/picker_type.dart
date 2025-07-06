import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../finance/new_type.dart';

class AppTypePicker extends StatelessWidget {
  const AppTypePicker({
    super.key,
    this.type = '',
    this.subType = '',
    required this.initial,
    required this.typeEntries,
    required this.onSelect,
    this.secondary,
    this.color,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.svp = false,
    this.showNew = false,
  });

  final String type;
  final String subType;
  final String initial;
  final Map typeEntries;
  final Function(dynamic chosenType, dynamic chosenValue) onSelect;
  final Widget Function(dynamic chosenType, dynamic chosenValue)? secondary;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool svp;
  final bool showNew;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        width: 300,
        items: [
          ValueListenableBuilder(
              valueListenable: local(features.subTypes).listenable(),
              builder: (context, box, wdgt) {
                Map userTypes = box.get('${type}_$subType', defaultValue: {});

                return Container(
                  constraints: BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    padding: padC('l4,r4,t8,b8'),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        if (showNew && type.isNotEmpty) NewType(type: type, subType: subType),
                        if (showNew && type.isNotEmpty) tph(),
                        //
                        Wrap(
                          spacing: sw(),
                          runSpacing: sw(),
                          children: [
                            //
                            for (MapEntry<dynamic, dynamic> entry in typeEntries.entries.toList())
                              Planet(
                                onPressed: () => onSelect(entry.key, entry.value),
                                svp: true,
                                padding: padC(secondary != null ? 'l12,r3,t3,b3' : 'l12,r6,t3,b3'),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(child: AppText(entry.key)),
                                    if (secondary != null) spw(),
                                    if (secondary != null) secondary!(entry.key, entry.value),
                                  ],
                                ),
                              ),
                            //
                            for (var type in userTypes.keys.toList()) MenuItem(label: type, onTap: () => onSelect(type, typeEntries[type])),
                            //
                          ],
                        ),
                        //
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
      padding: padding,
      color: color,
      radius: borderRadius,
      srp: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: AppText(initial, color: textColor)),
          tpw(),
          AppIcon(dropIcon, size: normal, color: textColor),
        ],
      ),
    );
  }
}
