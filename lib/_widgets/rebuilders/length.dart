import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_helpers/common/global.dart';
import '../../_services/hive/boxes.dart';
import '../../_services/hive/store.dart';

class LengthRebuilder extends StatefulWidget {
  const LengthRebuilder({
    super.key,
    required this.feature,
    required this.child,
  });

  final String feature;
  final Widget Function() child;

  @override
  State<LengthRebuilder> createState() => _LengthRebuilderState();
}

class _LengthRebuilderState extends State<LengthRebuilder> {
  int oldCount = 0;
  late Box box;

  @override
  void initState() {
    box = local(widget.feature);
    oldCount = box.length;
    box.listenable().addListener(boxListener);
    super.initState();
  }

  @override
  void dispose() {
    box.listenable().removeListener(boxListener);
    super.dispose();
  }

  Future<void> boxListener() async {
    if (box.length != oldCount) {
      oldCount = box.length;
      rebuildBox.put(widget.feature, getUniqueId());
      // show('rebuilt : ${widget.feature}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: rebuildBox.listenable(keys: [widget.feature]),
      builder: (ctx, box, wdg) {
        return widget.child();
      },
    );
  }
}
