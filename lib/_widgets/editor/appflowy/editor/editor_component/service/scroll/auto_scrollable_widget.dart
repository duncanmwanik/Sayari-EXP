// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../../../util/platform_extension.dart';
import 'auto_scroller.dart';

class AutoScrollableWidget extends StatefulWidget {
  const AutoScrollableWidget({
    super.key,
    this.shrinkWrap = false,
    required this.scrollController,
    required this.builder,
  });

  final bool shrinkWrap;
  final ScrollController scrollController;
  final Widget Function(
    BuildContext context,
    AutoScroller autoScroller,
  ) builder;

  @override
  State<AutoScrollableWidget> createState() => _AutoScrollableWidgetState();
}

class _AutoScrollableWidgetState extends State<AutoScrollableWidget> {
  late AutoScroller _autoScroller;
  late ScrollableState _scrollableState;

  @override
  void dispose() {
    _scrollableState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget builder(context) {
      return widget.builder(context, _autoScroller);
    }

    _scrollableState = ScrollableState();
    _initAutoScroller();

    if (widget.shrinkWrap) {
      return widget.builder(context, _autoScroller);
    } else {
      return Builder(
        builder: builder,
      );
    }
  }

  void _initAutoScroller() {
    _autoScroller = AutoScroller(
      _scrollableState,
      velocityScalar: PlatformExtension.isDesktopOrWeb ? 25 : 100,
      onScrollViewScrolled: () {
        // _autoScroller.continueToAutoScroll();
      },
    );
  }
}
