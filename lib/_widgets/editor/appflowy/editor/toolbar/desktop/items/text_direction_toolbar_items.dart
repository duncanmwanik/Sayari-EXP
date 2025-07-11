import '../../../../appflowy_editor.dart';
import 'utils/tooltip_util.dart';

final List<ToolbarItem> textDirectionItems = [
  _TextDirectionToolbarItem(
    id: 'text_direction_auto',
    name: blockComponentTextDirectionAuto,
    iconName: 'text_direction_auto',
  ),
  _TextDirectionToolbarItem(
    id: 'text_direction_ltr',
    name: blockComponentTextDirectionLTR,
    iconName: 'text_direction_ltr',
  ),
  _TextDirectionToolbarItem(
    id: 'text_direction_rtl',
    name: blockComponentTextDirectionRTL,
    iconName: 'text_direction_rtl',
  ),
];

class _TextDirectionToolbarItem extends ToolbarItem {
  _TextDirectionToolbarItem({
    required String id,
    required String name,
    required String iconName,
  }) : super(
          id: 'editor.$id',
          group: 7,
          isActive: onlyShowInTextType,
          builder: (
            context,
            editorState,
            highlightColor,
            iconColor,
            tooltipBuilder,
          ) {
            final selection = editorState.selection!;
            final nodes = editorState.getNodesInSelection(selection);
            final isHighlight = nodes.every(
              (n) => n.attributes[blockComponentTextDirection] == name,
            );
            final child = SVGIconItemWidget(
              iconName: 'toolbar/$iconName',
              isHighlight: isHighlight,
              highlightColor: highlightColor,
              iconColor: iconColor,
              onPressed: () => editorState.updateNode(
                selection,
                (node) => node.copyWith(
                  attributes: {
                    ...node.attributes,
                    blockComponentTextDirection: isHighlight ? null : name,
                  },
                ),
              ),
            );

            if (tooltipBuilder != null) {
              return tooltipBuilder(
                context,
                id,
                getTooltipText(id),
                child,
              );
            }

            return child;
          },
        );
}
