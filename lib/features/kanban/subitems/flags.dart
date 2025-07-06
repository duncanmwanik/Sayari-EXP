import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_services/hive/store.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/other.dart';
import 'flag.dart';

class ItemFlagList extends StatelessWidget {
  const ItemFlagList({super.key, required this.flagList, this.isTinyFlag = false});

  final List flagList;
  final bool isTinyFlag;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
          spacing: 2,
          runSpacing: 2,
          children: List.generate(flagList.length, (index) {
            String flagId = flagList[index];

            // If the flag is not deleted
            if (local(features.flags).containsKey(flagId)) {
              return Padding(
                padding: padT('r'),
                child: ItemFlag(
                  flagId: flagId,
                  isTinyFlag: isTinyFlag,
                  onPressedDelete: () {
                    flagList.remove(flagId);
                    state.input.update('g', joinList(flagList));
                  },
                ),
              );
            }
            // If not available, we remove the item flag from item data
            else {
              removeFlag(flagId);
              return NoWidget();
            }
          })),
    );
  }

  Future<void> removeFlag(String flag) async {
    await Future.delayed(Duration.zero);
    flagList.remove(flag);
    state.input.update('g', joinList(flagList));
  }
}
