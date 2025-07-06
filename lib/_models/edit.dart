//
// edited item
//
import '../_helpers/extentions/strings.dart';

class EditedKey {
  EditedKey({
    this.action = 'c',
    this.parentKey = '',
    required this.key,
    this.value = '',
    this.toSync = true,
  });

  String parentKey;
  String key;
  dynamic value;
  String action;
  bool toSync;

  bool isFile() => key.isFile();
  bool isDelete() => action == 'd';
}
