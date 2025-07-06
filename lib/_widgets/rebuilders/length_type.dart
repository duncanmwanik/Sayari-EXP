import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_helpers/common/global.dart';
import '../../_helpers/debug/debug.dart';
import '../../_services/hive/boxes.dart';
import '../../_services/hive/store.dart';
import '../../_variables/features.dart';
import '../../features/notes/_helpers/chosen.dart';
import '../../features/notes/_helpers/chosen_id.dart';

class LengthRebuilderType extends StatefulWidget {
  const LengthRebuilderType({
    super.key,
    required this.types,
    this.id,
    required this.builder,
  });

  final List<String> types;
  final String? id;
  final Widget Function() builder;

  @override
  State<LengthRebuilderType> createState() => _LengthRebuilderTypeState();
}

class _LengthRebuilderTypeState extends State<LengthRebuilderType> {
  List oldList = [];
  String uniqueKey = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    uniqueKey = '${widget.types}${widget.id}';
    oldList = await (widget.id != null ? getChosenItemsId(widget.id!) : getChosenItems(widget.types));
    local(features.docs).listenable().addListener(boxListener);
  }

  @override
  void dispose() {
    local(features.docs).listenable().removeListener(boxListener);
    super.dispose();
  }

  Future<void> boxListener() async {
    List newList = await (widget.id != null ? getChosenItemsId(widget.id!) : getChosenItems(widget.types));

    // show('old : $oldList');
    // show('new : $newList');

    if (!ListEquality().equals(oldList, newList)) {
      oldList = newList;
      rebuildBox.put(uniqueKey, getUniqueId());
      show('rebuilt : $uniqueKey');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: rebuildBox.listenable(keys: [uniqueKey]),
      builder: (x, box, w) {
        return widget.builder();
      },
    );
  }
}
