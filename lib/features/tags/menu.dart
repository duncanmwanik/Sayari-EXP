import '../../_models/item.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import 'manager.dart';

Menu tagsMenu({
  String title = '',
  Item? doc,
  required Function(String) onUpdate,
  bool isSelection = false,
}) {
  return Menu(items: [
    //
    MenuItem(label: 'Choose tag${isSelection ? 's' : ''}', faded: true, sh: true, popTrailing: true),
    menuDivider(),
    TagManager(item: doc, isPopup: true, isSelection: isSelection, onUpdate: onUpdate),
    //
  ]);
}
