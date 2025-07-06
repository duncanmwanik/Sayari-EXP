import '../../../_helpers/common/global.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';

class Tag {
  Tag({required this.id});
  final String id;

  String data() => local(features.tags).get(id, defaultValue: 'x,tag');
  String name() => isDefault() ? id : splitList(data()).last;
  String color() => isDefault() ? 'x' : splitList(data()).first;
  bool isDefault() => ['All', 'Archive', 'Trash'].contains(id);
  bool hasColor() => color() != 'x';
}
