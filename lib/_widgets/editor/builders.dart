import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../others/checkbox.dart';
import 'appflowy/appflowy_editor.dart';

Map<String, BlockComponentBuilder> customComponentBuilder({required double scale}) {
  scale = scale;

  return {
    ...standardBlockComponentBuilderMap,
    //
    ParagraphBlockKeys.type: ParagraphBlockComponentBuilder(
      showPlaceholder: (editorState, node) => editorState.document.isEmpty,
      configuration: standardBlockComponentConfiguration.copyWith(
        placeholderText: (_) => 'Start typing or enter / for commands',
      ),
    ),
    // todo
    TodoListBlockKeys.type: TodoListBlockComponentBuilder(
      iconBuilder: (context, node, onCheck) {
        final checked = node.attributes[TodoListBlockKeys.checked] as bool;
        return AppCheckBox(
          size: normal * scale,
          isChecked: checked,
          onTap: onCheck,
          margin: padC('r${scale * 4}'),
          borderColor: styler.textColor(faded: true),
        );
      },
    ),
    // quote
    QuoteBlockKeys.type: QuoteBlockComponentBuilder(
      iconBuilder: (context, node) {
        return Planet(
          width: 5,
          height: 20,
          padding: noPadding,
          margin: padM('r'),
          color: styler.textColor(extraFaded: true),
        );
      },
    ),
    // info
    // image
  };
}

// todo: 2.8
// bullet: 2
// numbered: 1.4
