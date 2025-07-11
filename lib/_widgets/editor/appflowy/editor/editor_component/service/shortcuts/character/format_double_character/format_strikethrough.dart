import 'format_double_characters.dart';
import '../../character_shortcut_event.dart';

const _tile = '~';

/// format the text surrounded by double asterisks to bold
///
/// - support
///   - desktop
///   - mobile
///   - web
///
final CharacterShortcutEvent formatDoubleTilesToStrikethrough = CharacterShortcutEvent(
  key: 'format the text surrounded by double asterisks to bold',
  character: _tile,
  handler: (editorState) async => handleFormatByWrappingWithDoubleCharacter(
    editorState: editorState,
    character: _tile,
    formatStyle: DoubleCharacterFormatStyle.strikethrough,
  ),
);
