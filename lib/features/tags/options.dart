import '../../_state/_providers.dart';
import '../../_theme/variables.dart';
import '../../_widgets/menu/confirmation.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import '_helpers/delete_tag.dart';
import 'var/tag_model.dart';

Menu tagOptionsMenu(Tag tag) {
  return Menu(
    items: [
      MenuItem(
        label: 'Edit Tag',
        leading: editIcon,
        onTap: () => state.focus.set(tag.id),
      ),
      MenuItem(
        label: 'Delete Tag',
        leading: deleteIcon,
        color: red,
        menu: confirmationMenu(
          title: 'Delete tag: <b>${tag.name()}</b>?',
          yeslabel: 'Delete',
          onAccept: () => deleteTag(tag.id),
        ),
      ),
    ],
  );
}
