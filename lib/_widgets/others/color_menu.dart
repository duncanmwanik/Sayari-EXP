import '../../_theme/spacing.dart';
import '../menu/menu_item.dart';
import '../menu/model.dart';
import 'color_picker.dart';

Menu colorMenu({
  String? selectedColor,
  String? title,
  Function(String newColor)? onSelect,
  Function()? onRemove,
  bool showRemove = true,
  bool showNone = false,
}) {
  return Menu(
    width: 300,
    items: [
      //
      MenuItem(label: title ?? 'Choose color', faded: true, sh: true, popTrailing: true),
      menuDivider(), ph(1),
      //
      AppColorPicker(
        selectedColor: selectedColor,
        onSelect: onSelect,
        onRemove: onRemove,
        showRemove: showRemove,
        showNone: showNone,
      )
      //
    ],
  );
}
