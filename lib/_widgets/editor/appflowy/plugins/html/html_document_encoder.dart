import 'dart:convert';

import 'package:collection/collection.dart';
import '../../appflowy_editor.dart';

class DocumentHTMLEncoder extends Converter<Document, String> {
  DocumentHTMLEncoder({this.encodeParsers = const []});
  final List<HTMLNodeParser> encodeParsers;

  @override
  String convert(Document input) {
    final buffer = StringBuffer();
    for (final node in input.root.children) {
      HTMLNodeParser? parser = encodeParsers.firstWhereOrNull(
        (element) => element.id == node.type,
      );
      if (parser != null) {
        buffer.write(
          parser.transformNodeToHTMLString(
            node,
            encodeParsers: encodeParsers,
          ),
        );
      }
    }
    return buffer.toString();
  }
}
