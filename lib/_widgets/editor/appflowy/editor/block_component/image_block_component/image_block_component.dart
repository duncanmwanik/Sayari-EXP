import 'package:flutter/material.dart';
import '../../../appflowy_editor.dart';
import 'package:provider/provider.dart';

class ImageBlockKeys {
  const ImageBlockKeys._();

  static const String type = 'image';

  /// The align data of a image block.
  ///
  /// The value is a String.
  /// left, center, right
  static const String align = 'align';

  /// The image src of a image block.
  ///
  /// The value is a String.
  /// It can be a url or a base64 string(web).
  static const String url = 'url';

  /// The height of a image block.
  ///
  /// The value is a double.
  static const String width = 'width';

  /// The width of a image block.
  ///
  /// The value is a double.
  static const String height = 'height';
}

Node imageNode({
  required String url,
  String align = 'center',
  double? height,
  double? width,
}) {
  return Node(
    type: ImageBlockKeys.type,
    attributes: {
      ImageBlockKeys.url: url,
      ImageBlockKeys.align: align,
      ImageBlockKeys.height: height,
      ImageBlockKeys.width: width,
    },
  );
}

typedef ImageBlockComponentMenuBuilder = Widget Function(
  Node node,
  ImageBlockComponentWidgetState state,
);

class ImageBlockComponentBuilder extends BlockComponentBuilder {
  ImageBlockComponentBuilder({
    super.configuration,
    this.showMenu = false,
    this.menuBuilder,
  });

  /// Whether to show the menu of this block component.
  final bool showMenu;

  ///
  final ImageBlockComponentMenuBuilder? menuBuilder;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return ImageBlockComponentWidget(
      key: node.key,
      node: node,
      showActions: showActions(node),
      configuration: configuration,
      actionBuilder: (context, state) => actionBuilder(
        blockComponentContext,
        state,
      ),
      showMenu: showMenu,
      menuBuilder: menuBuilder,
    );
  }

  @override
  BlockComponentValidate get validate => (node) => node.delta == null && node.children.isEmpty;
}

class ImageBlockComponentWidget extends BlockComponentStatefulWidget {
  const ImageBlockComponentWidget({
    super.key,
    required super.node,
    super.showActions,
    super.actionBuilder,
    super.configuration = const BlockComponentConfiguration(),
    this.showMenu = false,
    this.menuBuilder,
  });

  /// Whether to show the menu of this block component.
  final bool showMenu;

  final ImageBlockComponentMenuBuilder? menuBuilder;

  @override
  State<ImageBlockComponentWidget> createState() => ImageBlockComponentWidgetState();
}

class ImageBlockComponentWidgetState extends State<ImageBlockComponentWidget> with SelectableMixin, BlockComponentConfigurable {
  @override
  BlockComponentConfiguration get configuration => widget.configuration;

  @override
  Node get node => widget.node;

  final imageKey = GlobalKey();
  RenderBox? get _renderBox => context.findRenderObject() as RenderBox?;

  late final editorState = Provider.of<EditorState>(context, listen: false);

  final showActionsNotifier = ValueNotifier<bool>(false);

  bool alwaysShowMenu = false;

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final attributes = node.attributes;
    final src = attributes[ImageBlockKeys.url];

    final alignment = AlignmentExtension.fromString(
      attributes[ImageBlockKeys.align] ?? 'center',
    );
    final width = attributes[ImageBlockKeys.width]?.toDouble() ?? MediaQuery.of(context).size.width;
    final height = attributes[ImageBlockKeys.height]?.toDouble();

    Widget child = ResizableImage(
      src: src,
      width: width,
      height: height,
      editable: editorState.editable,
      alignment: alignment,
      onResize: (width) {
        final transaction = editorState.transaction
          ..updateNode(node, {
            ImageBlockKeys.width: width,
          });
        editorState.apply(transaction);
      },
    );

    child = Padding(
      key: imageKey,
      padding: padding,
      child: child,
    );

    child = BlockSelectionContainer(
      node: node,
      delegate: this,
      listenable: editorState.selectionNotifier,
      remoteSelection: editorState.remoteSelections,
      blockColor: editorState.editorStyle.selectionColor,
      supportTypes: const [
        BlockSelectionType.block,
      ],
      child: child,
    );

    if (widget.showActions && widget.actionBuilder != null) {
      child = BlockComponentActionWrapper(
        node: node,
        actionBuilder: widget.actionBuilder!,
        child: child,
      );
    }

    if (widget.showMenu && widget.menuBuilder != null) {
      child = MouseRegion(
        onEnter: (_) => showActionsNotifier.value = true,
        onExit: (_) {
          if (!alwaysShowMenu) {
            showActionsNotifier.value = false;
          }
        },
        hitTestBehavior: HitTestBehavior.opaque,
        opaque: false,
        child: ValueListenableBuilder<bool>(
          valueListenable: showActionsNotifier,
          builder: (context, value, child) {
            return Stack(
              children: [
                BlockSelectionContainer(
                  node: node,
                  delegate: this,
                  listenable: editorState.selectionNotifier,
                  remoteSelection: editorState.remoteSelections,
                  cursorColor: editorState.editorStyle.cursorColor,
                  selectionColor: editorState.editorStyle.selectionColor,
                  child: child!,
                ),
                if (value) widget.menuBuilder!(widget.node, this),
              ],
            );
          },
          child: child,
        ),
      );
    }

    return child;
  }

  @override
  Position start() => Position(path: widget.node.path, offset: 0);

  @override
  Position end() => Position(path: widget.node.path, offset: 1);

  @override
  Position getPositionInOffset(Offset start) => end();

  @override
  bool get shouldCursorBlink => false;

  @override
  CursorStyle get cursorStyle => CursorStyle.cover;

  @override
  Rect getBlockRect({
    bool shiftWithBaseOffset = false,
  }) {
    final imageBox = imageKey.currentContext?.findRenderObject();
    if (imageBox is RenderBox) {
      return Offset.zero & imageBox.size;
    }
    return Rect.zero;
  }

  @override
  Rect? getCursorRectInPosition(
    Position position, {
    bool shiftWithBaseOffset = false,
  }) {
    if (_renderBox == null) {
      return null;
    }
    final size = _renderBox!.size;
    return Rect.fromLTWH(-size.width / 2.0, 0, size.width, size.height);
  }

  @override
  List<Rect> getRectsInSelection(
    Selection selection, {
    bool shiftWithBaseOffset = false,
  }) {
    if (_renderBox == null) {
      return [];
    }
    final parentBox = context.findRenderObject();
    final imageBox = imageKey.currentContext?.findRenderObject();
    if (parentBox is RenderBox && imageBox is RenderBox) {
      return [
        imageBox.localToGlobal(Offset.zero, ancestor: parentBox) & imageBox.size,
      ];
    }
    return [Offset.zero & _renderBox!.size];
  }

  @override
  Selection getSelectionInRange(Offset start, Offset end) => Selection.single(
        path: widget.node.path,
        startOffset: 0,
        endOffset: 1,
      );

  @override
  Offset localToGlobal(
    Offset offset, {
    bool shiftWithBaseOffset = false,
  }) =>
      _renderBox!.localToGlobal(offset);
}

extension AlignmentExtension on Alignment {
  static Alignment fromString(String name) {
    switch (name) {
      case 'left':
        return Alignment.centerLeft;
      case 'right':
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }
}
