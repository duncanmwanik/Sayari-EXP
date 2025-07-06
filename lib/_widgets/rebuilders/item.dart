import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_services/hive/boxes.dart';

class ItemRebuilder extends StatelessWidget {
  const ItemRebuilder({
    super.key,
    required this.itemKey,
    required this.builder,
  });

  final String itemKey;
  final Widget Function(dynamic) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: rebuildBox.listenable(keys: [itemKey]),
        builder: (x, box, w) {
          return builder(box.get(itemKey));
        });
  }
}
