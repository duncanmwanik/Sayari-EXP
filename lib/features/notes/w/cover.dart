import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_widgets/files/overview.dart';

class DocCover extends StatelessWidget {
  const DocCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (x, input, w) {
      return Visibility(
        visible: input.item.showCover(),
        child: ItemCover(item: input.item),
      );
    });
  }
}
