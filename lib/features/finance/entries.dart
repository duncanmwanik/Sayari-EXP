import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../_models/item.dart';
import '../../_state/input.dart';
import '../../_theme/spacing.dart';
import '_helpers/helpers.dart';
import 'entry.dart';

class Entries extends StatelessWidget {
  const Entries({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List entriesKeys = getEntryKeys();
      entriesKeys = entriesKeys.reversed.toList();

      return Wrap(
        runSpacing: th(),
        children: [
          for (String key in entriesKeys)
            Entry(
              entry: Item(
                id: key,
                type: key.substring(1, 2),
                data: input.item.data[key],
              ),
            ),
        ],
      );
    });
  }
}
