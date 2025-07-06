import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import 'link.dart';

class SharedLinks extends StatelessWidget {
  const SharedLinks({super.key});

  @override
  Widget build(BuildContext context) {
    List links = state.share.item.sharedlinks();

    return Column(
      spacing: sh(),
      children: List.generate(links.length, (index) {
        return SharedLink(
          item: Item(
            id: links[index],
            data: state.share.item.data[links[index]],
          ),
        );
      }),
    );
  }
}
