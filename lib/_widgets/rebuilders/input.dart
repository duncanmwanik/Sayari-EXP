import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_state/input.dart';

class InputListener extends StatelessWidget {
  const InputListener({
    super.key,
    this.enabled = true,
    this.item,
    required this.builder,
  });

  final bool enabled;
  final Item? item;
  final Widget Function(InputProvider input, Item item, bool enabled) builder;

  @override
  Widget build(BuildContext context) {
    bool enabled_ = item != null ? false : enabled;

    if (enabled_) {
      return Consumer<InputProvider>(builder: (context, input, child) {
        return builder(input, input.item, enabled_);
      });
    } else {
      return builder(state.input, item ?? state.input.item, enabled_);
    }
  }
}
