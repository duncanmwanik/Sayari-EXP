import 'package:flutter/material.dart';
import '../../../appflowy_editor.dart';
import '../../editor_component/service/renderer/block_component_action.dart';

typedef BlockComponentActionBuilder = Widget Function(
  BuildContext context,
  BlockComponentActionState state,
);

class BlockComponentActionWrapper extends StatefulWidget {
  const BlockComponentActionWrapper({
    super.key,
    required this.node,
    required this.child,
    required this.actionBuilder,
  });

  final Node node;
  final Widget child;
  final BlockComponentActionBuilder actionBuilder;

  @override
  State<BlockComponentActionWrapper> createState() => _BlockComponentActionWrapperState();
}

class _BlockComponentActionWrapperState extends State<BlockComponentActionWrapper> implements BlockComponentActionState {
  final showActionsNotifier = ValueNotifier<bool>(false);

  bool isDisposed = false;

  bool _alwaysShowActions = false;
  bool get alwaysShowActions => _alwaysShowActions;
  @override
  set alwaysShowActions(bool alwaysShowActions) {
    if (isDisposed) {
      return;
    }
    _alwaysShowActions = alwaysShowActions;
    if (_alwaysShowActions == false && showActionsNotifier.value == true) {
      showActionsNotifier.value = false;
    }
  }

  @override
  void initState() {
    super.initState();

    if (forceShowBlockAction) {
      alwaysShowActions = true;
      showActionsNotifier.value = true;
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    showActionsNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => showActionsNotifier.value = true,
      onExit: (_) => showActionsNotifier.value = alwaysShowActions || false,
      hitTestBehavior: HitTestBehavior.opaque,
      opaque: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: showActionsNotifier,
            builder: (context, value, child) => BlockComponentActionContainer(
              node: widget.node,
              showActions: value,
              actionBuilder: (context) => widget.actionBuilder(context, this),
            ),
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
